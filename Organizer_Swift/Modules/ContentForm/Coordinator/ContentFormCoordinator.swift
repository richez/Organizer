//
//  ContentFormCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

protocol ContentFormCoordinatorProtocol: AnyObject {
    func finish()
}

final class ContentFormCoordinator: ChildCoordinator, ContentFormCoordinatorProtocol {
    // MARK: - Properties

    private let mode: ContentFormMode
    private let project: Project
    unowned private let navigationController: UINavigationController

    weak var parent: ParentCoordinator?

    // MARK: - Initialization

    init(mode: ContentFormMode,
         project: Project,
         navigationController: UINavigationController) {
        self.mode = mode
        self.navigationController = navigationController
        self.project = project
    }

    // MARK: - Coordinator

    func start() {
        let contentFormViewModel = ContentFormViewModel(mode: self.mode, project: self.project)
        let contentFormViewController = ContentFormViewController(viewModel: contentFormViewModel, coordinator: self)
        self.navigationController.present(contentFormViewController, animated: true)
    }
}

