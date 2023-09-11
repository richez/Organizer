//
//  ProjectDetailViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

final class ProjectDetailViewController: UIViewController {
    private lazy var contentView = ProjectDetailView()

    private unowned let coordinator: ProjectDetailCoordinatorProtocol
    private let viewModel: ProjectDetailViewModel

    // MARK: - Initialization

    init(viewModel: ProjectDetailViewModel, coordinator: ProjectDetailCoordinatorProtocol) {
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

private extension ProjectDetailViewController {
    func setup() {
    }
}
