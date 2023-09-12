//
//  ProjectContentCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

protocol ProjectContentCoordinatorProtocol: AnyObject {
    func showProjectContentCreator()
}

final class ProjectContentCoordinator: ParentCoordinator, ChildCoordinator {
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
        let projectContentViewModel = ProjectContentViewModel(project: self.project)
        let projectContentViewController = ProjectContentViewController(
            viewModel: projectContentViewModel,
            coordinator: self
        )
        self.navigationController.setPopAction({ [weak self] in
            self?.finish()
        }, for: projectContentViewController)
        self.navigationController.pushViewController(projectContentViewController, animated: true)
    }
}

// MARK: - ProjectContentCoordinatorProtocol

extension ProjectContentCoordinator: ProjectContentCoordinatorProtocol {
    func showProjectContentCreator() {
        let projectContentCreatorCoordinator = ProjectContentCreatorCoordinator(
            navigationController: self.navigationController
        )
        self.start(child: projectContentCreatorCoordinator)
    }
}

