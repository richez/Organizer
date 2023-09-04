//
//  ProjectsCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class ProjectsCoordinator: ChildCoordinator {
    unowned let window: UIWindow
    weak var parent: ParentCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let projectsViewController = ProjectsViewController()
        self.window.rootViewController = projectsViewController
    }
}
