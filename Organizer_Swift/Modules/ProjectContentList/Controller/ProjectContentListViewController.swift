//
//  ProjectContentListViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

final class ProjectContentListViewController: UIViewController {
    private lazy var contentView: ProjectContentListView = .init()
    private lazy var navbarTitleView: NavbarTitleView = .init()

    private let viewModel: ProjectContentListViewModel
    private unowned let coordinator: ProjectContentListCoordinatorProtocol

    private lazy var dataSource: ProjectContentListDataSource = .init(tableView: self.contentView.tableView)

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
        self.updateNavbarTitle()
        self.updateList(animated: false)
        self.updateMenu()
    }
}

private extension ProjectContentListViewController {
    // MARK: - Setup

    func setup() {
        self.contentView.delegate = self

        self.navigationItem.titleView = self.navbarTitleView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: self.viewModel.rightBarImageName)
        )

        self.contentView.configure(with: self.viewModel.viewConfiguration)

        self.observeContentNotification()
    }

    // MARK: - Updates

    func updateNavbarTitle() {
        self.navbarTitleView.configure(with: self.viewModel.navigationBarTitle)
    }

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
            self?.updateNavbarTitle()
            self?.updateList(animated: true)
            self?.updateMenu()
        }
        self.navigationItem.rightBarButtonItem?.menu = UIMenu(configuration: menuConfiguration)
    }

    // MARK: - Notification

    func observeContentNotification() {
        NotificationCenter.default.addObserver(forName: .didCreateContent, object: nil, queue: .current) { [weak self] _ in
            self?.updateList(animated: true)
            self?.updateMenu()
        }
        NotificationCenter.default.addObserver(forName: .didUpdateContent, object: nil, queue: .current) { [weak self] _ in
            self?.updateList(animated: true)
            self?.updateMenu()
        }
    }
}

// MARK: - ProjectContentListViewDelegate

extension ProjectContentListViewController: ProjectContentListViewDelegate {
    func didSelectContent(at indexPath: IndexPath) {
        // TODO: handle selection
    }

    func didTapSwipeAction(_ action: ProjectContentListSwipeAction, at indexPath: IndexPath) -> Bool {
        switch action {
        case .delete:
            return self.deleteContent(at: indexPath)
        case .edit:
            return self.editContent(at: indexPath)
        }
    }

    func didTapContextMenuAction(_ action: ProjectContentListContextMenuAction, at indexPath: IndexPath) {
        switch action {
        case .openBrowser:
            break // TODO: handle open
        case .copyLink:
            break // TODO: handle copy
        case .edit:
            self.editContent(at: indexPath)
        case .delete:
            self.deleteContent(at: indexPath)
        }
    }

    func didTapCreateButton() {
        self.coordinator.showProjectContentForm(mode: .create)
    }
}

// MARK: - Actions

private extension ProjectContentListViewController {
    @discardableResult
    func deleteContent(at indexPath: IndexPath) -> Bool {
        do {
            let contentDescription = try self.dataSource.contentDescription(for: indexPath)
            try self.viewModel.deleteContent(with: contentDescription.id)
            self.dataSource.applySnapshot(deleting: contentDescription, animated: true)
            self.updateMenu()
            return true
        } catch {
            print("Fail to delete project: \(error)")
            self.coordinator.show(error: error)
            return false
        }
    }

    @discardableResult
    func editContent(at indexPath: IndexPath) -> Bool {
        do {
            let contentID = try self.dataSource.contentDescription(for: indexPath).id
            let content = try self.viewModel.content(with: contentID)
            self.coordinator.showProjectContentForm(mode: .update(content))
            return true
        } catch {
            print("Fail to edit content: \(error)")
            self.coordinator.show(error: error)
            return false
        }
    }
}
