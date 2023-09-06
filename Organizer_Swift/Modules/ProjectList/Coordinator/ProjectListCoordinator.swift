//
//  ProjectListCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class ProjectListCoordinator: ChildCoordinator {
    unowned let window: UIWindow
    weak var parent: ParentCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let projectListViewModel = ProjectListViewModel()
        let projectListViewController = ProjectListViewController(viewModel: projectListViewModel)
        let projectListNavigationController = UINavigationController(rootViewController: projectListViewController)
        self.window.rootViewController = projectListNavigationController
    }
}
