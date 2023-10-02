//
//  NavigationController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

/// Custom navigation controller used to add actions when one of its controller is popped.
///
/// This class listen to `UINavigationControllerDelegate.didShow` method to detect when a view
/// controller is popped and execute the associated pop action setted when calling ``setPopAction(_:for:)``
/// method.
///
/// It's particularly usefull when using the ``Coordinator`` pattern in order to free the controller
/// associated coordinator from memory.
///```
/// func start() {
///     let viewController = UIViewController()
///     self.navigationController.setPopAction({ [weak self] in
///         self?.finish()
///     }, for: viewController)
///      self.navigationController.pushViewController(viewController, animated: true)
/// }
/// ```
final class NavigationController: UINavigationController {
    // MARK: - Properties

    private var popActions: [UIViewController: () -> Void] = [:]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool)
    {
        // Check whether the view controller we’re moving from is not contained into
        // our view controllers array to make sure we are popping it and not pushing a different
        // controller on top
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(fromViewController) else {
            return
        }

        self.runPopAction(for: fromViewController)
    }
}

// MARK: - Pop Actions

extension NavigationController {
    func setPopAction(_ action: @escaping () -> Void, for controller: UIViewController) {
        self.popActions[controller] = action
    }

    private func runPopAction(for controller: UIViewController) {
        guard let popAction = self.popActions[controller] else { return }
        popAction()
        self.popActions.removeValue(forKey: controller)
    }
}
