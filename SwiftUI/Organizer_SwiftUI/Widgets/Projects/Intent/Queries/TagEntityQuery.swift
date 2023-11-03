//
//  TagEntityQuery.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import AppIntents
import Foundation

struct TagEntityQuery: EntityQuery {
    func entities(for identifiers: [TagEntity.ID]) async throws -> [TagEntity] {
        return identifiers.map(TagEntity.init(name:))
    }

    func suggestedEntities() async throws -> [TagEntity] {
        let store = WidgetStore()
        let formatter = ProjectFormatter()
        let projects = try store.projects(propertiesToFetch: [\.theme])
        let themes = formatter.themes(from: projects)
        return themes.map(TagEntity.init(name:))
    }
}
