//
//  ContentFormViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

final class ContentFormViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: ContentFormViewModel
    private unowned let coordinator: ContentFormCoordinator
    private var linkTitleTask: Task<Void, Never>?

    // MARK: View

    private lazy var contentView: ContentFormView = .init()

    // MARK: - Initialization

    init(viewModel: ContentFormViewModel, coordinator: ContentFormCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        self.view = self.contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
}

private extension ContentFormViewController {
    // MARK: - Setup

    func setup() {
        self.contentView.delegate = self
        self.presentationController?.delegate = self

        self.contentView.configure(with: self.viewModel.viewConfiguration)
    }
}

// MARK: - ContentFormViewDelegate

extension ContentFormViewController: ContentFormViewDelegate {  
    func didTapOnView() {
        self.view.endEditing(true)
    }

    func didEditFields(with values: ContentFormFieldValues) {
        let isFieldsValid = self.viewModel.isFieldsValid(for: values)
        self.contentView.isSaveButtonEnabled = isFieldsValid
    }

    func didEndEditingLink(_ link: String) {
        let isValidLink = self.viewModel.isValidLink(link)
        self.contentView.fieldsView.isNameGetterButtonEnabled = isValidLink
        self.contentView.fieldsView.isLinkErrorLabelHidden = isValidLink
    }

    func didTapNameGetterButton(link: String) {
        self.view.endEditing(true)
        self.contentView.startLoader()

        self.linkTitleTask = Task { [weak self] in
            do {
                let title = try await self?.viewModel.title(of: link)
                try Task.checkCancellation()
                self?.contentView.fieldsView.set(name: title ?? "")
                self?.contentView.stopLoader()
            } catch {
                print("Fail to retrieve link title: \(error)")
                self?.coordinator.show(error: error)
                self?.contentView.stopLoader()
            }
        }
    }

    func didTapSaveButton(with values: ContentFormFieldValues) {
        self.view.endEditing(true)
        self.viewModel.commit(values: values)
        self.dismiss(animated: true)
        self.coordinator.finish()
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension ContentFormViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.linkTitleTask?.cancel()
        self.coordinator.finish()
    }
}
