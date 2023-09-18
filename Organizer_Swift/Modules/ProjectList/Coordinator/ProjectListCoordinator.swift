//
//  ProjectListCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

protocol ProjectListCoordinatorProtocol: AnyObject {
    func showProjectForm(mode: ProjectFormMode)
    func showContentList(of project: Project)
    func show(error: Error)
}

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
        let projectListViewModel = ProjectListViewModel()
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
        let projectCreatorCoordinator = ProjectCreatorCoordinator(
            mode: mode,
            navigationController: self.navigationController!
        )
        self.start(child: projectCreatorCoordinator)
    }

    func showContentList(of project: Project) {
        let projectContentListCoordinator = ProjectContentListCoordinator(
            navigationController: self.navigationController!,
            project: project
        )
        self.start(child: projectContentListCoordinator)
    }

    func show(error: Error) {
        self.navigationController!.presentError(error)
    }
}
