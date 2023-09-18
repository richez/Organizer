//
//  ProjectListViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class ProjectListViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView: ProjectListView = .init()
    private lazy var navbarTitleView: NavbarTitleView = .init()

    private let viewModel: ProjectListViewModel
    private unowned let coordinator: ProjectListCoordinatorProtocol

    private lazy var dataSource: ProjectListDataSource = .init(tableView: self.contentView.tableView)

    // MARK: - Initialization

    init(viewModel: ProjectListViewModel, coordinator: ProjectListCoordinatorProtocol) {
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

        self.observeProjectNotifications()
    }

    // MARK: - Updates

    func updateNavbarTitle() {
        self.navbarTitleView.configure(with: self.viewModel.navigationBarTitle)
    }

    func updateList(animated: Bool) {
        do {
            let projectDescriptions = try self.viewModel.fetchProjectDescriptions()
            self.dataSource.applySnapshot(
                section: self.viewModel.section,
                projectDescriptions: projectDescriptions,
                animated: animated
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

    func observeProjectNotifications() {
        NotificationCenter.default.addObserver(forName: .didCreateProject, object: nil, queue: .current) { [weak self] _ in
            self?.updateList(animated: true)
            self?.updateMenu()
        }
        NotificationCenter.default.addObserver(forName: .didUpdateProject, object: nil, queue: .current) { [weak self] _ in
            self?.updateList(animated: true)
            self?.updateMenu()
        }
        NotificationCenter.default.addObserver(forName: .didUpdateProjectContent, object: nil, queue: .current) { [weak self] _ in
            // The view is not visible when we update the project so we don't need to animate the change
            self?.updateList(animated: false)
        }
    }
}

// MARK: - ProjectListViewDelegate

extension ProjectListViewController: ProjectListViewDelegate {
    func didSelectProject(at indexPath: IndexPath) {
        do {
            let projectID = try self.dataSource.projectDescription(for: indexPath).id
            let project = try self.viewModel.project(with: projectID)
            self.coordinator.showContentList(of: project)
            self.contentView.tableView.deselectRow(at: indexPath, animated: false)
        } catch {
            print("Fail to show project: \(error)")
            self.coordinator.show(error: error)
        }
    }

    func didTapDelete(at indexPath: IndexPath) -> Bool {
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

    func didTapEdit(at indexPath: IndexPath) -> Bool {
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

    func didTapProjectCreatorButton() {
        self.coordinator.showProjectForm(mode: .create)
    }
}
