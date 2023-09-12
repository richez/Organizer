//
//  ProjectContentCreatorCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

protocol ProjectContentCreatorCoordinatorProtocol: AnyObject {
    func show(error: Error)
    func finish()
}

final class ProjectContentCreatorCoordinator: ChildCoordinator {
    // MARK: - Properties

    unowned private let navigationController: UINavigationController

    weak var parent: ParentCoordinator?

    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    func start() {
        let projectContentCreatorViewModel = ProjectContentCreatorViewModel()
        let projectContentCreatorViewController = ProjectContentCreatorViewController(
            viewModel: projectContentCreatorViewModel,
            coordinator: self
        )
        self.navigationController.present(projectContentCreatorViewController, animated: true)
    }
}

// MARK: - ProjectContentCreatorCoordinatorProtocol

extension ProjectContentCreatorCoordinator: ProjectContentCreatorCoordinatorProtocol {
    func show(error: Error) {
        self.navigationController.presentedViewController?.presentError(error)
    }
}

