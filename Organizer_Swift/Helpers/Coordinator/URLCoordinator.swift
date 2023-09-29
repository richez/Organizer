//
//  URLCoordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 28/09/2023.
//

import UIKit
import SafariServices

enum URLCoordinatorMode {
    /// Open the provided `URL` in a `SafariViewController`
    case inApp(URL)

    /// Open the provided `URL` in the browser or associated app using `UIApplication.open`.
    case external(URL)
}

final class URLCoordinator: ChildCoordinator {
    private let mode: URLCoordinatorMode
    unowned private let navigationController: NavigationController

    var parent: ParentCoordinator?

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
            let safariViewController = SFSafariViewController(url: url)
            // TODO: set colors
            self.navigationController.present(safariViewController, animated: true)
        case .external(let url):
            UIApplication.shared.open(url)
        }
    }
}
