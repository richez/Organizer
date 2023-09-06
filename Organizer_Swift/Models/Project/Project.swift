//
//  Project.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

final class Project {
    let id: UUID
    var title: String

    init(id: UUID = .init(), title: String) {
        self.id = id
        self.title = title
    }
}

extension Project {
    static var sample: [Project] {
        [
            Project(title: "Auto-Construction"),
            Project(title: "Menuiserie"),
            Project(title: "Recherche Emploi")
        ]
    }
}
