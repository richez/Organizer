//
//  Coordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import Foundation

// TODO: add some/any keywords accros app

/// A type representing an object that handles the navigation
/// between view controllers.
protocol Coordinator: AnyObject {
    /// Calling this method will tell the associated object to take
    /// control over the app flow.
    func start()
}

/// A type that conforms to the `Coordinator` protocol that handles
/// child objetcs to temporarily give them control over the app by using
/// its ``start(child:)`` and ``finish(child:)`` methods.
protocol ParentCoordinator: Coordinator {
    var children: [Coordinator] { get set }
}

/// A type that conforms to the `Coordinator` protocol and that can
/// be started or finished by a `ParentCoordinator` object.
protocol ChildCoordinator: Coordinator {
    var parent: ParentCoordinator? { get set }
}

extension ParentCoordinator {
    func start(child: some ChildCoordinator) {
        self.children.append(child)
        child.parent = self
        child.start()
    }

    func finish(child: some ChildCoordinator) {
        guard let index = self.children.firstIndex(where: { coordinator in
            child === coordinator
        }) else {
            return
        }

        self.children.remove(at: index)
    }
}

extension ChildCoordinator {
    func finish() {
        self.parent?.finish(child: self)
    }
}
