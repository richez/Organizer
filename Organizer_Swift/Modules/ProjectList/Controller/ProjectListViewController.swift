//
//  ProjectListViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class ProjectListViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView = ProjectListView()

    private let viewModel: ProjectListViewModel
    private unowned let coordinator: ProjectListCoordinatorProtocol

    private lazy var dataSource = ProjectListDataSource(tableView: self.contentView.tableView)

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
        self.dataSource.delegate = self
        self.contentView.delegate = self

        self.navigationController?.navigationBar.applyAppearance()
        self.navigationItem.backButtonDisplayMode = .minimal
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: self.viewModel.rightBarImageName)
        )

        self.observeProjectNotifications()
    }

    // MARK: - Updates

    func updateNavbarTitle() {
        self.title = self.viewModel.navigationBarTitle
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
        NotificationCenter.default.addObserver(forName: .didUpdateProjectContent, object: nil, queue: .current) { [weak self] _ in
            // The view is not visible when we update the project so we don't need to animate the change
            self?.updateList(animated: false)
        }
    }
}

// MARK: - ProjectListDataSourceDelegate

extension ProjectListViewController: ProjectListDataSourceDelegate {
    func didTapDelete(on projectDescription: ProjectDescription) {
        do {
            try self.viewModel.deleteProject(with: projectDescription.id)
            self.dataSource.applySnapshot(deleting: projectDescription, animated: true)
        } catch {
            print("Fail to delete project: \(error)")
            self.coordinator.show(error: error)
        }
    }
}

// MARK: - ProjectListViewDelegate

extension ProjectListViewController: ProjectListViewDelegate {
    func didSelectProject(at indexPath: IndexPath) {
        do {
            let projectID = self.dataSource.projectIdentifier(for: indexPath)
            let project = try self.viewModel.project(with: projectID)
            self.coordinator.showProjectContent(of: project)
            self.contentView.tableView.deselectRow(at: indexPath, animated: false)
        } catch {
            self.coordinator.show(error: error)
        }
    }

    func didTapProjectCreatorButton() {
        self.coordinator.showProjectCreator()
    }
}
