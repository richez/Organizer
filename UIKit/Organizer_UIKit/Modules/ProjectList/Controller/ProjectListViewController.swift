//
//  ProjectListViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import Combine
import UIKit

final class ProjectListViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: ProjectListViewModel
    private unowned let coordinator: ProjectListCoordinator
    private lazy var dataSource: ProjectListDataSource = .init(tableView: self.contentView.tableView)

    var subscriptions: Set<AnyCancellable> = .init()

    // MARK: Views

    private lazy var contentView: ProjectListView = .init()
    private lazy var navbarTitleView: NavbarTitleView = .init()

    // MARK: - Initialization

    init(viewModel: ProjectListViewModel, coordinator: ProjectListCoordinator) {
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

private extension ProjectListViewController {
    // MARK: - Setup

    func setup() {
        self.contentView.delegate = self

        self.navigationController?.navigationBar.applyAppearance()
        self.navigationItem.titleView = self.navbarTitleView
        self.navigationItem.backButtonDisplayMode = .minimal
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
            let projectDescriptions = try self.viewModel.fetchProjectDescriptions()
            self.dataSource.applySnapshot(
                section: self.viewModel.section, projectDescriptions: projectDescriptions, animated: animated
            )
        } catch {
            print("Fail to fetch projects: \(error)")
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
        let center = NotificationCenter.default
        
        center.publisher(for: .didCreateProject)
            .sink { @MainActor [weak self] _ in
                self?.updateList(animated: true)
                self?.updateMenu()
            }
            .store(in: &self.subscriptions)

        center.publisher(for: .didUpdateProject)
            .sink { @MainActor [weak self] _ in
                self?.updateList(animated: true)
                self?.updateMenu()
            }
            .store(in: &self.subscriptions)

        center.publisher(for: .didUpdateProjectContent)
            .sink { @MainActor [weak self] _ in
                // The view is not visible when we update a project content so we don't 
                // need to animate the change
                self?.updateList(animated: false)
            }
            .store(in: &self.subscriptions)

        center.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { @MainActor [weak self] _ in
                if self?.viewModel.shareExtensionDidAddContent == true {
                    self?.coordinator.popToRoot(animated: false)
                    self?.updateList(animated: false)
                    self?.viewModel.resetShareExtensionSetting()
                }
            }
            .store(in: &self.subscriptions)
    }
}

// MARK: - ProjectListViewDelegate

extension ProjectListViewController: ProjectListViewDelegate {
    func didSelectProject(at indexPath: IndexPath) {
        self.showProject(at: indexPath)
    }

    func didTapSwipeAction(_ action: ProjectListSwipeAction, at indexPath: IndexPath) -> Bool {
        switch action {
        case .delete:
            return self.deleteProject(at: indexPath)
        case .edit:
            return self.editProject(at: indexPath)
        }
    }

    func didTapContextMenuAction(_ action: ProjectListContextMenuAction, at indexPath: IndexPath) {
        switch action {
        case .duplicate:
            self.duplicateProject(at: indexPath)
        case .edit:
            self.editProject(at: indexPath)
        case .delete:
            self.deleteProject(at: indexPath)
        }
    }

    func didTapCreateButton() {
        self.coordinator.showProjectForm(mode: .create)
    }
}

// MARK: - Actions

private extension ProjectListViewController {
    func showProject(at indexPath: IndexPath) {
        do {
            let projectID = try self.dataSource.projectDescription(for: indexPath).id
            let project = try self.viewModel.project(with: projectID)
            self.coordinator.showContentList(of: project)
            self.contentView.tableView.deselectRow(at: indexPath, animated: false)
        } catch {
            print("Fail to show project: \(error)")
            self.coordinator.show(error: error)
            self.contentView.tableView.deselectRow(at: indexPath, animated: false)
        }
    }

    @discardableResult
    func deleteProject(at indexPath: IndexPath) -> Bool {
        do {
            let projectDescription = try self.dataSource.projectDescription(for: indexPath)
            try self.viewModel.deleteProject(with: projectDescription.id)
            self.dataSource.applySnapshot(deleting: projectDescription, animated: true)
            self.updateMenu()
            return true
        } catch {
            print("Fail to delete project: \(error)")
            self.coordinator.show(error: error)
            return false
        }
    }

    @discardableResult
    func editProject(at indexPath: IndexPath) -> Bool {
        do {
            let projectID = try self.dataSource.projectDescription(for: indexPath).id
            let project = try self.viewModel.project(with: projectID)
            self.coordinator.showProjectForm(mode: .update(project))
            return true
        } catch {
            print("Fail to edit project: \(error)")
            self.coordinator.show(error: error)
            return false
        }
    }

    func duplicateProject(at indexPath: IndexPath) {
        do {
            let projectID = try self.dataSource.projectDescription(for: indexPath).id
            try self.viewModel.duplicateProject(with: projectID)
            self.updateList(animated: true)
        } catch {
            print("Fail to duplicate project: \(error)")
            self.coordinator.show(error: error)
        }
    }
}
