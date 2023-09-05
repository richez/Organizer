//
//  Projects.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

final class Projects {
    var title: String

    init(title: String) {
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
