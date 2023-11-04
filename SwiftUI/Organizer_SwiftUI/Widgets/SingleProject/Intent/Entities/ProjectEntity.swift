//
//  ProjectEntity.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import AppIntents
import Foundation

struct ProjectEntity: AppEntity, Identifiable {
    var id: UUID
    var title: String

    init(from project: Project) {
        self.id = project.identifier
        self.title = project.title
    }

    var displayRepresentation: DisplayRepresentation {
        .init(stringLiteral: self.title)
    }
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Project")
    static var defaultQuery = ProjectEntityQuery()
}
