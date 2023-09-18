//
//  ProjectFormViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

final class ProjectFormViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView: ProjectFormView = .init()

    private let viewModel: ProjectFormViewModel
    private unowned let coordinator: ProjectFormCoordinatorProtocol

    // MARK: - Initialization

    init(viewModel: ProjectFormViewModel, coordinator: ProjectFormCoordinatorProtocol) {
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

private extension ProjectFormViewController {
    func setup() {
        self.contentView.delegate = self
        self.presentationController?.delegate = self

        self.contentView.configure(with: self.viewModel.fieldsDescription)
    }
}

// MARK: - ProjectFormViewDelegate

extension ProjectFormViewController: ProjectFormViewDelegate {
    func didEditFields(name: String, theme: String) {
        let isFieldsValid = self.viewModel.isFieldsValid(name: name, theme: theme)
        self.contentView.isSaveButtonEnabled = isFieldsValid
    }

    func didTapOnView() {
        self.view.endEditing(true)
    }

    func didTapSaveButton(name: String, theme: String) {
        self.view.endEditing(true)
        do {
            try self.viewModel.commit(name: name, theme: theme)
            self.dismiss(animated: true)
            self.coordinator.finish()
        } catch {
            print("Fail to create project: \(error)")
            self.coordinator.show(error: error)
        }
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension ProjectFormViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.coordinator.finish()
    }
}
