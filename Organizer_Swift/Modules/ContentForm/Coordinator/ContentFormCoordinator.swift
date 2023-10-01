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

    weak var parent: ParentCoordinator?

    // MARK: - Initialization

    init(mode: ContentFormMode, project: Project, navigationController: UINavigationController) {
        self.mode = mode
        self.project = project
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    func start() {
        let uRLMetadataConfiguration = URLMetadataConfiguration(shouldFetchSubresources: false, timeout: 20)
        let urlMetadataProvider = URLMetadataProvider(configuration: uRLMetadataConfiguration)
        let notificationCenter = NotificationCenter.default

        let contentFormViewModel = ContentFormViewModel(
            mode: self.mode, 
            project: self.project,
            urlMetadataProvider: urlMetadataProvider,
            notificationCenter: notificationCenter
        )
        let contentFormViewController = ContentFormViewController(viewModel: contentFormViewModel, coordinator: self)

        self.navigationController.present(contentFormViewController, animated: true)
    }
}

// MARK: - ContentFormCoordinatorProtocol

extension ContentFormCoordinator: ContentFormCoordinatorProtocol {
    func show(error: Error) {
        self.navigationController.presentedViewController?.presentError(error)
    }
}

