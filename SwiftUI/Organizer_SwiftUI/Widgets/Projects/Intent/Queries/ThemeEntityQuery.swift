//
//  ThemeEntityQuery.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import AppIntents
import Foundation

struct ThemeEntityQuery: EntityQuery {
    func entities(for identifiers: [ThemeEntity.ID]) async throws -> [ThemeEntity] {
        return identifiers.map(ThemeEntity.init(name:))
    }

    func suggestedEntities() async throws -> [ThemeEntity] {
        let store = WidgetStore()
        let formatter = ProjectFormatter()
        let projects: [Project] = try store.models(propertiesToFetch: [\.theme])
        let themes = formatter.themes(from: projects)
        return themes.map(ThemeEntity.init(name:))
    }
}
