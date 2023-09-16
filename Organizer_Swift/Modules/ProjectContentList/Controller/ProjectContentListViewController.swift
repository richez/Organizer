//
//  ProjectContentListViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

final class ProjectContentListViewController: UIViewController {
    private lazy var contentView = ProjectContentListView()

    private let viewModel: ProjectContentListViewModel
    private unowned let coordinator: ProjectContentListCoordinatorProtocol

    private lazy var dataSource = ProjectContentListDataSource(tableView: self.contentView.tableView)

    // MARK: - Initialization

    init(viewModel: ProjectContentListViewModel, coordinator: ProjectContentListCoordinatorProtocol) {
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
        self.updateList(animated: false)
        self.updateMenu()
    }
}

private extension ProjectContentListViewController {
    // MARK: - Setup

    func setup() {
        self.dataSource.delegate = self
        self.contentView.delegate = self

        self.title = self.viewModel.navigationBarTitle // TODO: update title based on menu selection
        self.navigationController?.navigationBar.applyAppearance()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: self.viewModel.rightBarImageName)
        )

        self.observeContentNotification()
    }

    // MARK: - Updates

    func updateList(animated: Bool) {
        do {
            let contentDescriptions = try self.viewModel.fetchContentDescriptions()
            self.dataSource.applySnapshot(
                section: self.viewModel.section,
                contentDescriptions: contentDescriptions,
                animated: animated
            )
        } catch {
            print("Fail to fetch content: \(error)")
            self.coordinator.show(error: error)
        }
    }

    func updateMenu() {
        let menuConfiguration = self.viewModel.menuConfiguration { [weak self] in
            self?.updateList(animated: true)
            self?.updateMenu()
        }
        self.navigationItem.rightBarButtonItem?.menu = UIMenu(configuration: menuConfiguration)
    }

    // MARK: - Notification

    func observeContentNotification() {
        NotificationCenter.default.addObserver(forName: .didCreateContent, object: nil, queue: .current) { [weak self] _ in
            self?.updateList(animated: true)
        }
    }
}

// MARK: - ProjectContentListDataSourceDelegate

extension ProjectContentListViewController: ProjectContentListDataSourceDelegate {
    func didTapDelete(on contentDescription: ProjectContentDescription) {
        do {
            try self.viewModel.deleteContent(with: contentDescription.id)
            self.dataSource.applySnapshot(deleting: contentDescription, animated: true)
        } catch {
            print("Fail to delete project: \(error)")
            self.coordinator.show(error: error)
        }
    }
}

// MARK: - ProjectContentListViewDelegate

extension ProjectContentListViewController: ProjectContentListViewDelegate {
    func didSelectContent(at indexPath: IndexPath) {
        // TODO: handle selection
    }

    func didTapContentCreatorButton() {
        self.coordinator.showProjectContentCreator()
    }
}

