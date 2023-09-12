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

    unowned private let navigationController: UINavigationController
    private let project: Project

    weak var parent: ParentCoordinator?

    // MARK: - Initialization

    init(navigationController: UINavigationController, project: Project) {
        self.navigationController = navigationController
        self.project = project
    }

    // MARK: - Coordinator

    func start() {
        let projectContentCreatorViewModel = ProjectContentCreatorViewModel(project: self.project)
        let projectContentCreatorViewController = ProjectContentCreatorViewController(
            viewModel: projectContentCreatorViewModel,
            coordinator: self
        )
        self.navigationController.present(projectContentCreatorViewController, animated: true)
    }
}

