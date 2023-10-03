//
//  ContentFormCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

final class ContentFormCoordinator: ChildCoordinator {
    // MARK: - Properties

    private let mode: ContentFormMode
    private let project: Project
    unowned private let navigationController: UINavigationController

    weak var parent: (any ParentCoordinator)?

    // MARK: - Initialization

    init(mode: ContentFormMode, project: Project, navigationController: UINavigationController) {
        self.mode = mode
        self.project = project
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    func start() {
        let contentFormViewController = ViewControllerFactory.contentForm(with: self.mode, project: self.project, coordinator: self)
        self.navigationController.present(contentFormViewController, animated: true)
    }
}

// MARK: - Public

extension ContentFormCoordinator {
    func show(error: Error) {
        self.navigationController.presentedViewController?.presentError(error)
    }
}

