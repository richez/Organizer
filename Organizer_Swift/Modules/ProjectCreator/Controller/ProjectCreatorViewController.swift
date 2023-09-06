//
//  ProjectCreatorViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

final class ProjectCreatorViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView = ProjectCreatorView()

    private unowned let coordinator: ProjectCreatorCoordinatorProtocol
    private let viewModel: ProjectCreatorViewModel

    // MARK: - Initialization

    init(viewModel: ProjectCreatorViewModel, coordinator: ProjectCreatorCoordinatorProtocol) {
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

private extension ProjectCreatorViewController {
    func setup() {
        self.contentView.delegate = self

        self.contentView.configure(with: self.viewModel.fieldsDescription)
    }
}

// MARK: - ProjectCreatorViewDelegate

extension ProjectCreatorViewController: ProjectCreatorViewDelegate {
    func didTapSaveButton() {
        self.view.endEditing(true)
        self.dismiss(animated: true)
        self.coordinator.finish()
    }
}
