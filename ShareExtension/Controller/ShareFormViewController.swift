//
//  ShareFormViewController.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import UIKit

final class ShareFormViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: ShareFormViewModel = .init()
    private var viewConfigurationTask: Task<Void, Never>?

    // MARK: View

    private lazy var contentView: ShareFormView = .init()


    // MARK: - Life Cycle

    override func loadView() {
        self.view = self.contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.viewConfigurationTask?.cancel()
    }
}


private extension ShareFormViewController {
    // MARK: - Setup

    func setup() {
        self.contentView.delegate = self

        self.loadViewConfiguration()
    }

    // MARK: - View Configuration

    func loadViewConfiguration() {
        self.contentView.startLoader()

        self.viewConfigurationTask = Task { [weak self] in
            do {
                let extensionItem = self?.extensionContext?.inputItems.first as? NSExtensionItem
                let viewConfiguration = try await self?.viewModel.viewConfiguration(with: extensionItem)
                try Task.checkCancellation()
                self?.contentView.configure(with: viewConfiguration)
                self?.contentView.stopLoader()
            } catch {
                print("Fail de load view configuration: \(error)")
                self?.contentView.configure(with: self?.viewModel.emptyViewConfiguration)
                self?.contentView.stopLoader()
                self?.presentLoadViewConfigurationError(error, alert: self?.viewModel.viewConfigurationErrorAlert)
            }
        }
    }

    // MARK: - Commit

    func commit(values: ShareFormFieldValues) {
        do {
            try self.viewModel.commit(values: values)
            self.extensionContext?.completeRequest(returningItems: nil)
        } catch {
            print("Fail to create content: \(error)")
            self.presentCommitError(error, alert: self.viewModel.commitErrorAlert, values: values)
        }
    }
}

// MARK: - ShareFormViewDelegate

extension ShareFormViewController: ShareFormViewDelegate {
    func didTapOnView() {
        self.view.endEditing(true)
    }

    func didEditFields(with values: ShareFormFieldValues) {
        let isFieldsValid = self.viewModel.isFieldsValid(for: values)
        self.contentView.isSaveButtonEnabled = isFieldsValid
    }

    func didChangeProjectSelection(to selectedProject: ProjectSelectedItem?) {
        self.contentView.isProjectTextFieldHidden = self.viewModel.shouldHideProjectTextField(for: selectedProject)
    }

    func didEndEditingLink(_ link: String) {
        self.contentView.isLinkErrorLabelHidden = link.isValidURL()
    }

    func didTapSaveButton(with values: ShareFormFieldValues) {
        self.commit(values: values)
    }
}

// MARK: - Errors

private extension ShareFormViewController {
    func presentLoadViewConfigurationError(_ error: Error, alert: ShareFormErrorAlert?) {
        guard let alert else { return }

        self.presentError(title: alert.title, actions: [
            UIAlertAction(title: alert.cancelTitle, style: .destructive, handler: { [weak self] _ in
                self?.extensionContext?.cancelRequest(withError: error)
            }),
            UIAlertAction(title: alert.retryTitle, style: .default, handler: { [weak self] _ in
                self?.loadViewConfiguration()
            })
        ])
    }

    func presentCommitError(_ error: Error, alert: ShareFormErrorAlert, values: ShareFormFieldValues) {
        self.presentError(title: alert.title, actions: [
            UIAlertAction(title: alert.cancelTitle, style: .destructive, handler: { [weak self] _ in
                self?.extensionContext?.cancelRequest(withError: error)
            }),
            UIAlertAction(title: alert.retryTitle, style: .default, handler: { [weak self] _ in
                self?.commit(values: values)
            })
        ])
    }

    func presentError(title: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        actions.forEach(alertController.addAction(_:))
        self.present(alertController, animated: true)
    }
}
