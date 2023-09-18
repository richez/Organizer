//
//  ProjectContentCreatorCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

protocol ProjectContentCreatorCoordinatorProtocol: AnyObject {
    func finish()
}

final class ProjectContentCreatorCoordinator: ChildCoordinator, ProjectContentCreatorCoordinatorProtocol {
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
        let projectContentCreatorViewModel = ProjectContentCreatorViewModel(mode: self.mode, project: self.project)
        let projectContentCreatorViewController = ProjectContentCreatorViewController(
            viewModel: projectContentCreatorViewModel,
            coordinator: self
        )
        self.navigationController.present(projectContentCreatorViewController, animated: true)
    }
}

