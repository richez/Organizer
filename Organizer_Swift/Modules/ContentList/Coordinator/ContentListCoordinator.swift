//
//  ContentListCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

final class ContentListCoordinator: ParentCoordinator, ChildCoordinator {
    // MARK: - Properties

    private let project: Project
    unowned private let navigationController: NavigationController

    weak var parent: (any ParentCoordinator)?
    var children: [any Coordinator] = []

    // MARK: - Initialization

    init(project: Project, navigationController: NavigationController) {
        self.project = project
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    func start() {
        let settings = ContentListSettings(suiteName: self.project.id.uuidString)
        let fetchDescriptor = ContentListFetchDescriptor(settings: settings)
        let menuConfigurator = ContentListMenuConfigurator(settings: settings)
        let notificationCenter = NotificationCenter.default

        let contentListViewModel = ContentListViewModel(
            project: self.project,
            settings: settings,
            fetchDescriptor: fetchDescriptor,
            menuConfigurator: menuConfigurator,
            notificationCenter: notificationCenter
        )
        let contentListViewController = ContentListViewController(viewModel: contentListViewModel, coordinator: self)

        self.navigationController.setPopAction({ [weak self] in
            self?.finish()
        }, for: contentListViewController)
        self.navigationController.pushViewController(contentListViewController, animated: true)
    }
}

// MARK: - Public

extension ContentListCoordinator {
    func showContentForm(mode: ContentFormMode) {
        let contentFormCoordinator = ContentFormCoordinator(
            mode: mode, project: self.project, navigationController: self.navigationController
        )
        self.start(child: contentFormCoordinator)
    }

    func showContent(url: URL, mode: ContentDisplayMode) {
        let urlCoordinatorMode = URLCoordinatorMode(displayMode: mode, url: url)
        let urlCoordinator = URLCoordinator(
            mode: urlCoordinatorMode, navigationController: self.navigationController
        )
        self.start(child: urlCoordinator)
    }

    func show(error: Error) {
        self.navigationController.presentError(error)
    }
}
