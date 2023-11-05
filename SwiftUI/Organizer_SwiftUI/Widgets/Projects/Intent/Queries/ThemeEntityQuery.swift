//
//  ThemeEntityQuery.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import AppIntents
import Foundation
import OSLog

private let logger = Logger(subsystem: "Widgets", category: "ThemeEntityQuery")

struct ThemeEntityQuery: EntityQuery {
    func entities(for identifiers: [ThemeEntity.ID]) async throws -> [ThemeEntity] {
        logger.info("Loading themes for identifiers: \(identifiers)")
        return identifiers.map(ThemeEntity.init(name:))
    }

    func suggestedEntities() async throws -> [ThemeEntity] {
        let store = WidgetStore()
        let formatter = ProjectFormatter()
        logger.info("Loading themes to suggest for specific theme...")
        let projects: [Project] = try store.models(propertiesToFetch: [\.theme])
        let themes = formatter.themes(from: projects)
        logger.info("Found \(themes) themes")
        return themes.map(ThemeEntity.init(name:))
    }
}
