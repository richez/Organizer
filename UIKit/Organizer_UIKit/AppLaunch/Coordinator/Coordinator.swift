//
//  Coordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import Foundation

/// A type representing an object that handles the navigation
/// between view controllers.
@MainActor
protocol Coordinator: AnyObject {
    /// Calling this method will tell the associated object to take
    /// control over the app flow.
    func start()
}

/// A type that conforms to the `Coordinator` protocol that handles
/// child objetcs to temporarily give them control over the app by using
/// its ``start(child:)`` and ``finish(child:)`` methods.
@MainActor
protocol ParentCoordinator: Coordinator {
    var children: [any Coordinator] { get set }
}

/// A type that conforms to the `Coordinator` protocol and that can
/// be started or finished by a `ParentCoordinator` object.
@MainActor
protocol ChildCoordinator: Coordinator {
    var parent: (any ParentCoordinator)? { get set }
}

extension ParentCoordinator {
    @MainActor
    func start(child: some ChildCoordinator) {
        self.children.append(child)
        child.parent = self
        child.start()
    }

    @MainActor
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
    @MainActor
    func finish() {
        self.parent?.finish(child: self)
    }
}
