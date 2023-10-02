//
//  UIViewController+RenderableError.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

/// A type representing an error that can be displayed on a `UIAlertController`
/// easily by using the `UIViewController.presentError(_:animated:completion)`
/// method.
protocol RenderableError: Error {
    var title: String { get }
    var message: String { get }
    var actionTitle: String { get }
}

/// A default ``RenderableError`` conforming type used when the error passed to
/// `UIViewController.presentError(_:animated:completion)` does not conform to it.
enum DefaultRenderableError: RenderableError {
    case unknown(Error)

    var title: String { "An unknown error occured" }
    var message: String { "Please try again later" }
    var actionTitle: String { "OK" }
}

extension UIViewController {
    /// Presents an `UIAlertController` for the specified `Error`. If the error conforms to ``RenderableError``,
    /// the associated values will be used in the alert. Otherwise, the ``DefaultRenderableError`` values are
    /// used.
    func presentError(_ error: Error, animated: Bool = true, completion: (() -> Void)? = nil) {
        switch error {
        case let error as RenderableError:
            self.presentError(error, animated: animated, completion: completion)
        default:
            self.presentError(DefaultRenderableError.unknown(error), animated: animated, completion: completion)
        }
    }

    private func presentError(_ error: RenderableError, animated: Bool, completion: (() -> Void)?) {
        let alertController = UIAlertController(
            title: error.title,
            message: error.message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: error.actionTitle, style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: animated, completion: completion)
    }
}
