//
//  AppLaunchCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class AppLaunchCoordinator: ParentCoordinator {
    // MARK: - Properties

    unowned private let window: UIWindow

    var children: [any Coordinator] = []

    // MARK: - Initialization

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Coordinator

    func start() {
        self.startProjectListCoordinator()
        self.window.makeKeyAndVisible()
    }
}

// MARK: - Helpers

private extension AppLaunchCoordinator {
    // MARK: Project List

    func startProjectListCoordinator() {
        let projectListCoordinator = ProjectListCoordinator(window: self.window)
        self.start(child: projectListCoordinator)
    }
}
