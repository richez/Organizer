//
//  ProjectFormCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

final class ProjectFormCoordinator: ChildCoordinator {
    // MARK: - Properties

    private let mode: ProjectFormMode
    unowned private let navigationController: UINavigationController

    weak var parent: (any ParentCoordinator)?

    // MARK: - Initialization

    init(mode: ProjectFormMode, navigationController: UINavigationController) {
        self.mode = mode
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    func start() {
        let dataStore = ProjectDataStore.shared
        let notificationCenter = NotificationCenter.default

        let projectFormViewModel = ProjectFormViewModel(
            mode: self.mode, dataStore: dataStore, notificationCenter: notificationCenter
        )
        let projectFormViewController = ProjectFormViewController(viewModel: projectFormViewModel, coordinator: self)

        self.navigationController.present(projectFormViewController, animated: true)
    }
}

// MARK: - Public

extension ProjectFormCoordinator {
    func show(error: Error) {
        self.navigationController.presentedViewController?.presentError(error)
    }
}
