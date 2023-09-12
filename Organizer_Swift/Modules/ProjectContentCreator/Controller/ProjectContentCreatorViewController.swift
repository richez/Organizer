//
//  ProjectContentCreatorViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

final class ProjectContentCreatorViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView = ProjectContentCreatorView()

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
    func setup() {
    }
}
