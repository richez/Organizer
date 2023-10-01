//
//  ContentListViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

final class ContentListViewController: UIViewController {
    private lazy var contentView: ContentListView = .init()
    private lazy var navbarTitleView: NavbarTitleView = .init()

    private let viewModel: ContentListViewModel
    private unowned let coordinator: ContentListCoordinatorProtocol

    private lazy var dataSource: ContentListDataSource = .init(tableView: self.contentView.tableView)

    // MARK: - Initialization

    init(viewModel: ContentListViewModel, coordinator: ContentListCoordinatorProtocol) {
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

private extension ContentListViewController {
    // MARK: - Setup

    func setup() {
        self.contentView.delegate = self

        self.navigationItem.titleView = self.navbarTitleView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: self.viewModel.rightBarImageName)
        )

        self.contentView.configure(with: self.viewModel.viewConfiguration)

        self.observeNotifications()
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

    func observeNotifications() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(forName: .didCreateContent, object: nil, queue: .main) { [weak self] _ in
            self?.updateList(animated: true)
            self?.updateMenu()
        }
        notificationCenter.addObserver(forName: .didUpdateContent, object: nil, queue: .main) { [weak self] _ in
            self?.updateList(animated: true)
            self?.updateMenu()
        }
    }
}

// MARK: - ContentListViewDelegate

extension ContentListViewController: ContentListViewDelegate {
    func didSelectContent(at indexPath: IndexPath) {
        self.showContent(at: indexPath, mode: .inApp)
    }

    func didTapSwipeAction(_ action: ContentListSwipeAction, at indexPath: IndexPath) -> Bool {
        switch action {
        case .delete:
            return self.deleteContent(at: indexPath)
        case .edit:
            return self.editContent(at: indexPath)
        }
    }

    func didTapContextMenuAction(_ action: ContentListContextMenuAction, at indexPath: IndexPath) {
        switch action {
        case .openBrowser:
            self.showContent(at: indexPath, mode: .external)
        case .copyLink:
            self.copyContentLink(at: indexPath)
        case .edit:
            self.editContent(at: indexPath)
        case .delete:
            self.deleteContent(at: indexPath)
        }
    }

    func didTapCreateButton() {
        self.coordinator.showContentForm(mode: .create)
    }
}

// MARK: - Actions

private extension ContentListViewController {
    func showContent(at indexPath: IndexPath, mode: ContentDisplayMode) {
        do {
            let contentID = try self.dataSource.contentDescription(for: indexPath).id
            let contentURL = try self.viewModel.contentURL(with: contentID)
            self.coordinator.showContent(url: contentURL, mode: mode)
            self.contentView.tableView.deselectRow(at: indexPath, animated: false)
        } catch {
            print("Fail to show content: \(error)")
            self.coordinator.show(error: error)
            self.contentView.tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
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
            self.coordinator.showContentForm(mode: .update(content))
            return true
        } catch {
            print("Fail to edit content: \(error)")
            self.coordinator.show(error: error)
            return false
        }
    }

    func copyContentLink(at indexPath: IndexPath) {
        do {
            let contentID = try self.dataSource.contentDescription(for: indexPath).id
            let contentURL = try self.viewModel.contentURL(with: contentID)
            UIPasteboard.general.url = contentURL
        } catch {
            print("Fail to copy content link: \(error)")
            self.coordinator.show(error: error)
        }
    }
}
