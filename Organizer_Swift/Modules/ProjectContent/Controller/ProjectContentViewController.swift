//
//  ProjectContentViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

final class ProjectContentViewController: UIViewController {
    private lazy var contentView = ProjectContentView()

    private let viewModel: ProjectContentViewModel
    private unowned let coordinator: ProjectContentCoordinatorProtocol

    private lazy var dataSource = ProjectContentDataSource(tableView: self.contentView.tableView)

    // MARK: - Initialization

    init(viewModel: ProjectContentViewModel, coordinator: ProjectContentCoordinatorProtocol) {
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
        self.updateList()
    }
}

private extension ProjectContentViewController {
    // MARK: - Setup

    func setup() {
        self.dataSource.delegate = self
        self.contentView.delegate = self

        self.title = self.viewModel.navigationBarTitle
        self.navigationController?.navigationBar.applyAppearance()
    }

    // MARK: - Updates

    func updateList() {
        let contentDescriptions = self.viewModel.fetchContentDescriptions()
        self.dataSource.applySnapshot(
            section: self.viewModel.section,
            contentDescriptions: contentDescriptions,
            animated: false
        )
    }
}

// MARK: - ProjectContentDataSourceDelegate

extension ProjectContentViewController: ProjectContentDataSourceDelegate {
    func didTapDelete(on contentDescription: ProjectContentDescription) {
        // TODO: handle deletion
    }
}

// MARK: - ProjectContentViewDelegate

extension ProjectContentViewController: ProjectContentViewDelegate {
    func didSelectContent(at indexPath: IndexPath) {
    }

    func didTapContentCreatorButton() {
    }
}

