//
//  AppLaunchCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class AppLaunchCoordinator: ParentCoordinator {
    unowned let window: UIWindow
    var children: [Coordinator] = []

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        self.startProjectsCoordinator()
        self.window.makeKeyAndVisible()
    }
}

private extension AppLaunchCoordinator {
    func startProjectsCoordinator() {
        let projectListCoordinator = ProjectListCoordinator(window: self.window)
        self.start(child: projectListCoordinator)
    }
}
