//
//  ProjectContentListCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

protocol ProjectContentListCoordinatorProtocol: AnyObject {
    func showProjectContentForm(mode: ProjectContentFormMode)
    func show(error: Error)
}

final class ProjectContentListCoordinator: ParentCoordinator, ChildCoordinator {
    // MARK: - Properties

    unowned private let navigationController: NavigationController
    private let project: Project

    weak var parent: ParentCoordinator?
    var children: [Coordinator] = []

    // MARK: - Initialization

    init(navigationController: NavigationController, project: Project) {
        self.navigationController = navigationController
        self.project = project
    }

    // MARK: - Coordinator

    func start() {
        let projectContentListViewModel = ProjectContentListViewModel(project: self.project)
        let projectContentListViewController = ProjectContentListViewController(
            viewModel: projectContentListViewModel,
            coordinator: self
        )
        self.navigationController.setPopAction({ [weak self] in
            self?.finish()
        }, for: projectContentListViewController)
        self.navigationController.pushViewController(projectContentListViewController, animated: true)
    }
}

// MARK: - ProjectContentListCoordinatorProtocol

extension ProjectContentListCoordinator: ProjectContentListCoordinatorProtocol {
    func showProjectContentForm(mode: ProjectContentFormMode) {
        let projectContentFormCoordinator = ProjectContentFormCoordinator(
            mode: mode,
            project: self.project,
            navigationController: self.navigationController
        )
        self.start(child: projectContentFormCoordinator)
    }

    func show(error: Error) {
        self.navigationController.presentError(error)
    }
}

