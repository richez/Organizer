//
//  Coordinator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
}

protocol ParentCoordinator: Coordinator {
    var children: [Coordinator] { get set }
}

protocol ChildCoordinator: Coordinator {
    var parent: ParentCoordinator? { get set }
}

extension ParentCoordinator {
    func start(child: ChildCoordinator) {
        self.children.append(child)
        child.parent = self
        child.start()
    }

    func finish(child: ChildCoordinator) {
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
