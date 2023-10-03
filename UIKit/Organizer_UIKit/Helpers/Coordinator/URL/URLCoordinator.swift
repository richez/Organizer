//
//  URLCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 28/09/2023.
//

import SafariServices
import UIKit

/// A coordinator that handles `URL` opening by presenting an `SFSafariViewController`
/// inside the app or redirecting to the default browser (`UIApplication.shared.open`)
/// depending on the passed ``URLCoordinatorMode``.
final class URLCoordinator: ChildCoordinator {
    // MARK: - Properties

    private let mode: URLCoordinatorMode
    unowned private let navigationController: NavigationController

    var parent: (any ParentCoordinator)?

    // MARK: - Initialization

    init(mode: URLCoordinatorMode, navigationController: NavigationController) {
        self.mode = mode
        self.navigationController = navigationController
    }


    // MARK: - Coordinator

    func start() {
        defer {
            // This coordinator only present controller or open an url
            // so it can be released right after taking the appropriate response.
            self.finish()
        }

        switch self.mode {
        case .inApp(let url):
            let safariViewController = ViewControllerFactory.safari(with: url)
            self.navigationController.present(safariViewController, animated: true)
        case .external(let url):
            UIApplication.shared.open(url)
        }
    }
}
