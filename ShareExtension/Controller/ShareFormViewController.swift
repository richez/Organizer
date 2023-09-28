//
//  ShareFormViewController.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import UIKit

final class ShareFormViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView: ShareFormView = .init()
    private let viewModel: ShareFormViewModel = .init()

    private var viewConfigurationTask: Task<Void, Never>?

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
                self?.contentView.configure(with: self?.viewModel.erroredViewConfiguration)
                self?.contentView.stopLoader()
            }
        }
    }
}

// MARK: - ShareFormViewDelegate

extension ShareFormViewController: ShareFormViewDelegate {
    func didTapOnView() {
        self.view.endEditing(true)
    }

    func didEditFields(selectedProject: ProjectSelectedItem?, type: String, link: String, name: String, theme: String) {
        let isFieldsValid = self.viewModel.isFieldsValid(
            selectedProject: selectedProject, type: type, link: link, name: name, theme: theme
        )
        self.contentView.isSaveButtonEnabled = isFieldsValid
    }

    func didChangeProjectSelection(to selectedProject: ProjectSelectedItem?) {
        self.contentView.isProjectTextFieldHidden = self.viewModel.shouldHideProjectTextField(for: selectedProject)
    }

    func didEndEditingLink(_ link: String) {
        self.contentView.isLinkErrorLabelHidden = link.isValidURL()
    }

    func didTapSaveButton(selectedProject: ProjectSelectedItem?, type: String, link: String, name: String, theme: String) {
        do {
            try self.viewModel.commit(selectedProjectItem: selectedProject, type: type, link: link, name: name, theme: theme)
            self.extensionContext?.completeRequest(returningItems: nil)
        } catch {
            print("Fail to create content: \(error)")
            self.contentView.set(error: self.viewModel.commitError)
            // TODO: show an alert showing error with 2 actions: "Cancel Request" and "Ok that lets him retry"
        }
    }
}
