//
//  ProjectCreatorCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

protocol ProjectCreatorCoordinatorProtocol: AnyObject {
    func show(error: Error)
    func finish()
}

final class ProjectCreatorCoordinator: ChildCoordinator {
    // MARK: - Properties

    unowned private let navigationController: UINavigationController

    weak var parent: ParentCoordinator?

    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    func start() {
        let projectCreatorViewModel = ProjectCreatorViewModel()
        let projectCreatorViewController = ProjectCreatorViewController(
            viewModel: projectCreatorViewModel,
            coordinator: self
        )
        self.navigationController.present(projectCreatorViewController, animated: true)
    }
}

// MARK: - ProjectCreatorCoordinatorProtocol

extension ProjectCreatorCoordinator: ProjectCreatorCoordinatorProtocol {
    func show(error: Error) {
        self.navigationController.presentedViewController?.presentError(error)
    }
}
