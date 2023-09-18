//
//  ProjectContentCreatorViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

final class ProjectContentCreatorViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView: ProjectContentCreatorView = .init()

    private let viewModel: ProjectContentCreatorViewModel
    private unowned let coordinator: ProjectContentCreatorCoordinatorProtocol

    // MARK: - Initialization

    init(viewModel: ProjectContentCreatorViewModel, coordinator: ProjectContentCreatorCoordinatorProtocol) {
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

private extension ProjectContentCreatorViewController {
    // MARK: - Setup
    func setup() {
        self.contentView.delegate = self
        self.presentationController?.delegate = self

        self.contentView.configure(with: self.viewModel.fieldsDescription)
    }
}

// MARK: - ProjectContentCreatorViewDelegate

extension ProjectContentCreatorViewController: ProjectContentCreatorViewDelegate {
    func didEditFields(name: String, theme: String, link: String) {
        let isFieldsValid = self.viewModel.isFieldsValid(name: name, theme: theme, link: link)
        self.contentView.isSaveButtonEnabled = isFieldsValid
    }
    
    func didTapOnView() {
        self.view.endEditing(true)
    }
    
    func didTapSaveButton(type: String, name: String, theme: String, link: String) {
        self.view.endEditing(true)
        self.viewModel.createContent(type: type, name: name, theme: theme, link: link)
        self.dismiss(animated: true)
        self.coordinator.finish()
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension ProjectContentCreatorViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.coordinator.finish()
    }
}
