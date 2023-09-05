//
//  Projects.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

final class Projects {
    let id: UUID
    var title: String

    init(id: UUID = .init(), title: String) {
        self.id = id
        self.title = title
    }
}

extension Projects {
    static var sample: [Projects] {
        [
            Projects(title: "Auto-Construction"),
            Projects(title: "Menuiserie"),
            Projects(title: "Recherche Emploi")
        ]
    }
}
