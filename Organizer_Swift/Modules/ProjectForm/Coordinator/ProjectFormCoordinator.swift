//
//  ProjectFormCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

protocol ProjectFormCoordinatorProtocol: AnyObject {
    func show(error: Error)
    func finish()
}

final class ProjectFormCoordinator: ChildCoordinator {
    // MARK: - Properties

    private let mode: ProjectFormMode
    unowned private let navigationController: UINavigationController

    weak var parent: ParentCoordinator?

    // MARK: - Initialization

    init(mode: ProjectFormMode, navigationController: UINavigationController) {
        self.mode = mode
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    func start() {
        let projectFormViewModel = ProjectFormViewModel(mode: self.mode)
        let projectFormViewController = ProjectFormViewController(
            viewModel: projectFormViewModel,
            coordinator: self
        )
        self.navigationController.present(projectFormViewController, animated: true)
    }
}

// MARK: - ProjectFormCoordinatorProtocol

extension ProjectFormCoordinator: ProjectFormCoordinatorProtocol {
    func show(error: Error) {
        self.navigationController.presentedViewController?.presentError(error)
    }
}
