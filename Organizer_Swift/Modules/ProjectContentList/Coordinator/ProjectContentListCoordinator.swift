//
//  ProjectContentListCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

protocol ProjectContentListCoordinatorProtocol: AnyObject {
    func showProjectContentCreator()
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
    func showProjectContentCreator() {
        let projectContentCreatorCoordinator = ProjectContentCreatorCoordinator(
            navigationController: self.navigationController,
            project: self.project
        )
        self.start(child: projectContentCreatorCoordinator)
    }

    func show(error: Error) {
        self.navigationController.presentError(error)
    }
}

