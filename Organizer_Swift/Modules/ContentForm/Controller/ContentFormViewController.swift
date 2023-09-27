//
//  ContentFormViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

final class ContentFormViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView: ContentFormView = .init()

    private let viewModel: ContentFormViewModel
    private unowned let coordinator: ContentFormCoordinatorProtocol

    private var linkTitleTask: Task<Void, Never>?

    // MARK: - Initialization

    init(viewModel: ContentFormViewModel, coordinator: ContentFormCoordinatorProtocol) {
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
    func didEditFields(type: String, link: String, name: String, theme: String) {
        let isFieldsValid = self.viewModel.isFieldsValid(type: type, link: link, name: name, theme: theme)
        self.contentView.isSaveButtonEnabled = isFieldsValid
        self.contentView.fieldsView.isNameGetterButtonEnabled = self.viewModel.isNameGetterEnabled(link: link)
    }
    
    func didTapOnView() {
        self.view.endEditing(true)
    }

    func didTapNameGetterButton(link: String) {
        self.view.endEditing(true)
        // TODO: show loader
        self.linkTitleTask = Task { [weak self] in
            do {
                let title = try await self?.viewModel.linkTitle(for: link)
                try Task.checkCancellation()
                self?.contentView.fieldsView.set(name: title ?? "")
            } catch {
                print("Fail to retrieve link title due to error: \(error)")
                self?.coordinator.show(error: error)
            }
        }
    }

    func didTapSaveButton(type: String, link: String, name: String, theme: String) {
        self.view.endEditing(true)
        self.viewModel.commit(type: type, link: link, name: name, theme: theme)
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
