//
//  ProjectListCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class ProjectListCoordinator: ParentCoordinator, ChildCoordinator {
    // MARK: - Properties

    unowned private let window: UIWindow
    weak private var navigationController: NavigationController?

    weak var parent: (any ParentCoordinator)?
    var children: [any Coordinator] = []

    // MARK: - Initialization

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Coordinator

    func start() {
        let dataStore = ProjectDataStore.shared
        let settings = ProjectListSettings()
        let fetchDescriptor = ProjectListFetchDescriptor(settings: settings)
        let menuConfigurator = ProjectListMenuConfigurator(settings: settings)

        let projectListViewModel = ProjectListViewModel(
            dataStore: dataStore, settings: settings, fetchDescriptor: fetchDescriptor, menuConfigurator: menuConfigurator
        )
        let projectListViewController = ProjectListViewController(viewModel: projectListViewModel, coordinator: self)
        let projectListNavigationController = NavigationController(rootViewController: projectListViewController)

        self.window.rootViewController = projectListNavigationController
        self.navigationController = projectListNavigationController
    }
}

// MARK: - Public

extension ProjectListCoordinator {
    func showProjectForm(mode: ProjectFormMode) {
        let projectFormCoordinator = ProjectFormCoordinator(
            mode: mode, navigationController: self.navigationController!
        )
        self.start(child: projectFormCoordinator)
    }

    func showContentList(of project: Project) {
        let contentListCoordinator = ContentListCoordinator(
            project: project, navigationController: self.navigationController!
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
