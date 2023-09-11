//
//  ProjectListCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

protocol ProjectListCoordinatorProtocol: AnyObject {
    func showProjectCreator()
    func showProjectDetail(for project: Project)
    func show(error: Error)
}

final class ProjectListCoordinator: ParentCoordinator, ChildCoordinator {
    // MARK: - Properties

    unowned let window: UIWindow
    weak private var navigationController: UINavigationController?

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
        let projectListNavigationController = UINavigationController(rootViewController: projectListViewController)
        self.window.rootViewController = projectListNavigationController
        self.navigationController = projectListNavigationController
    }
}

// MARK: - ProjectListCoordinatorProtocol

extension ProjectListCoordinator: ProjectListCoordinatorProtocol {
    func showProjectCreator() {
        let projectCreatorCoordinator = ProjectCreatorCoordinator(
            navigationController: self.navigationController!
        )
        self.start(child: projectCreatorCoordinator)
    }

    func showProjectDetail(for project: Project) {
        let projectDetailCoordinator = ProjectDetailCoordinator(
            navigationController: self.navigationController!,
            project: project
        )
        self.start(child: projectDetailCoordinator)
    }

    func show(error: Error) {
        self.navigationController!.presentError(error)
    }
}
