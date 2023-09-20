//
//  ContentListCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

protocol ContentListCoordinatorProtocol: AnyObject {
    func showContentForm(mode: ContentFormMode)
    func show(error: Error)
}

final class ContentListCoordinator: ParentCoordinator, ChildCoordinator {
    // MARK: - Properties

    private let project: Project
    unowned private let navigationController: NavigationController

    weak var parent: ParentCoordinator?
    var children: [Coordinator] = []

    // MARK: - Initialization

    init(project: Project, navigationController: NavigationController) {
        self.project = project
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    func start() {
        let settings = ContentListSettings(suiteName: project.id.uuidString)
        let contentListViewModel = ContentListViewModel(
            project: self.project,
            settings: settings,
            fetchDescriptor: ContentListFetchDescriptor(settings: settings),
            menuConfigurator: ContentListMenuConfigurator(settings: settings),
            pasteboardManager: PasteboardManager()
        )
        let contentListViewController = ContentListViewController(viewModel: contentListViewModel, coordinator: self)
        self.navigationController.setPopAction({ [weak self] in
            self?.finish()
        }, for: contentListViewController)
        self.navigationController.pushViewController(contentListViewController, animated: true)
    }
}

// MARK: - ContentListCoordinatorProtocol

extension ContentListCoordinator: ContentListCoordinatorProtocol {
    func showContentForm(mode: ContentFormMode) {
        let contentFormCoordinator = ContentFormCoordinator(
            mode: mode,
            project: self.project,
            navigationController: self.navigationController
        )
        self.start(child: contentFormCoordinator)
    }

    func show(error: Error) {
        self.navigationController.presentError(error)
    }
}

