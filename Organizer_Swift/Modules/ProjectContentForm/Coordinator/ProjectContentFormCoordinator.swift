//
//  ProjectContentFormCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

protocol ProjectContentFormCoordinatorProtocol: AnyObject {
    func finish()
}

final class ProjectContentFormCoordinator: ChildCoordinator, ProjectContentFormCoordinatorProtocol {
    // MARK: - Properties

    private let mode: ProjectContentFormMode
    private let project: Project
    unowned private let navigationController: UINavigationController

    weak var parent: ParentCoordinator?

    // MARK: - Initialization

    init(mode: ProjectContentFormMode,
         project: Project,
         navigationController: UINavigationController) {
        self.mode = mode
        self.navigationController = navigationController
        self.project = project
    }

    // MARK: - Coordinator

    func start() {
        let projectContentFormViewModel = ProjectContentFormViewModel(mode: self.mode, project: self.project)
        let projectContentFormViewController = ProjectContentFormViewController(
            viewModel: projectContentFormViewModel,
            coordinator: self
        )
        self.navigationController.present(projectContentFormViewController, animated: true)
    }
}

