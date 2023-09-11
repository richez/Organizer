//
//  ProjectDetailCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

protocol ProjectDetailCoordinatorProtocol: AnyObject {
}

final class ProjectDetailCoordinator: ChildCoordinator {
    // MARK: - Properties

    unowned private let navigationController: NavigationController
    private let project: Project

    weak var parent: ParentCoordinator?

    // MARK: - Initialization

    init(navigationController: NavigationController, project: Project) {
        self.navigationController = navigationController
        self.project = project
    }

    // MARK: - Coordinator

    func start() {
        let projectDetailViewModel = ProjectDetailViewModel(project: self.project)
        let projectDetailViewController = ProjectDetailViewController(
            viewModel: projectDetailViewModel,
            coordinator: self
        )
        self.navigationController.setPopAction({ [weak self] in
            self?.finish()
        }, for: projectDetailViewController)
        self.navigationController.pushViewController(projectDetailViewController, animated: true)
    }
}

// MARK: - ProjectDetailCoordinatorProtocol

extension ProjectDetailCoordinator: ProjectDetailCoordinatorProtocol {

}

