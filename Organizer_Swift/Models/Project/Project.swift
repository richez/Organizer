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
    var lastUpdatedDate: Date

    init(id: UUID = .init(), title: String, lastUpdatedDate: Date) {
        self.id = id
        self.title = title
        self.lastUpdatedDate = lastUpdatedDate
    }
}

extension Project {
    static var sample: [Project] {
        [
            Project(title: "Auto-Construction", lastUpdatedDate: .now),
            Project(title: "Menuiserie", lastUpdatedDate: Calendar.current.date(byAdding: .day, value: -1, to: .now)!),
            Project(title: "Recherche Emploi", lastUpdatedDate:  Calendar.current.date(byAdding: .day, value: -2, to: .now)!)
        ]
    }
}
