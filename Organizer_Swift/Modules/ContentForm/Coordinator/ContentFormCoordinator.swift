//
//  ContentFormCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

protocol ContentFormCoordinatorProtocol: AnyObject {
    func show(error: Error)
    func finish()
}

final class ContentFormCoordinator: ChildCoordinator {
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
        let urlMetadataProvider = URLMetadataProvider(
            configuration: URLMetadataConfiguration(shouldFetchSubresources: false, timeout: 20)
        )
        let contentFormViewModel = ContentFormViewModel(
            mode: self.mode, project: self.project, urlMetadataProvider: urlMetadataProvider
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

