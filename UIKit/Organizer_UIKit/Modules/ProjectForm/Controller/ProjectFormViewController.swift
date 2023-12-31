//
//  ProjectFormViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

final class ProjectFormViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: ProjectFormViewModel
    private unowned let coordinator: ProjectFormCoordinator

    // MARK: View

    private lazy var contentView: ProjectFormView = .init()

    // MARK: - Initialization

    init(viewModel: ProjectFormViewModel, coordinator: ProjectFormCoordinator) {
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
    // MARK: - Setup

    func setup() {
        self.contentView.delegate = self
        self.presentationController?.delegate = self

        self.contentView.configure(with: self.viewModel.viewConfiguration)
    }
}

// MARK: - ProjectFormViewDelegate

extension ProjectFormViewController: ProjectFormViewDelegate {
    func didTapOnView() {
        self.view.endEditing(true)
    }

    func didEditFields(with values: ProjectFormFieldValues) {
        let isFieldsValid = self.viewModel.isFieldsValid(for: values)
        self.contentView.isSaveButtonEnabled = isFieldsValid
    }

    func didTapSaveButton(with values: ProjectFormFieldValues) {
        self.view.endEditing(true)
        do {
            try self.viewModel.commit(values: values)
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
