//
//  ThemeEntityQuery.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import AppIntents
import Foundation
import OSLog

struct ThemeEntityQuery: EntityQuery {
    func entities(for identifiers: [ThemeEntity.ID]) async throws -> [ThemeEntity] {
        Logger.entityQueries.info("Loading themes for identifiers: \(identifiers)")

        return identifiers.map(ThemeEntity.init(name:))
    }

    func suggestedEntities() async throws -> [ThemeEntity] {
        let store = WidgetStore()
        let formatter = ProjectFormatter()

        Logger.entityQueries.info("Loading themes to suggest for specific theme...")
        let projects: [Project] = try store.models(propertiesToFetch: [\.theme])
        let themes = formatter.themes(from: projects)
        Logger.entityQueries.info("Found \(themes) themes")

        return themes.map(ThemeEntity.init(name:))
    }
}
