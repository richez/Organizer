//
//  ProjectListCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class ProjectListCoordinator: ParentCoordinator, ChildCoordinator {
    // MARK: - Properties

    unowned let window: UIWindow
    weak private var navigationController: NavigationController?

    weak var parent: ParentCoordinator?
    var children: [Coordinator] = []

    // MARK: - Initialization

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Coordinator

    func start() {
        let settings = ProjectListSettings()
        let projectListViewModel = ProjectListViewModel(
            dataStore: ProjectDataStore.shared,
            settings: settings,
            fetchDescriptor: ProjectListFetchDescriptor(settings: settings),
            menuConfigurator: ProjectListMenuConfigurator(settings: settings)
        )
        let projectListViewController = ProjectListViewController(
            viewModel: projectListViewModel,
            coordinator: self
        )
        let projectListNavigationController = NavigationController(rootViewController: projectListViewController)
        self.window.rootViewController = projectListNavigationController
        self.navigationController = projectListNavigationController
    }
}

// MARK: - ProjectListCoordinatorProtocol

extension ProjectListCoordinator: ProjectListCoordinatorProtocol {
    func showProjectForm(mode: ProjectFormMode) {
        let projectFormCoordinator = ProjectFormCoordinator(
            mode: mode,
            navigationController: self.navigationController!
        )
        self.start(child: projectFormCoordinator)
    }

    func showContentList(of project: Project) {
        let contentListCoordinator = ContentListCoordinator(
            project: project,
            navigationController: self.navigationController!
        )
        self.start(child: contentListCoordinator)
    }

    func popToRoot(animated: Bool) {
        self.navigationController!.popToRootViewController(animated: animated)
    }

    func show(error: Error) {
        self.navigationController!.presentError(error)
    }
}
