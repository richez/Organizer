//
//  ProjectEntityQuery.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import AppIntents
import Foundation
import OSLog

struct ProjectEntityQuery: EntityQuery {
    func entities(for identifiers: [ProjectEntity.ID]) async throws -> [ProjectEntity] {
        let store = WidgetStore()

        Logger.entityQueries.info("Loading projects for identifiers: \(identifiers)")
        let projects: [Project] = try store.models(
            predicate: #Predicate { identifiers.contains($0.identifier) },
            fetchLimit: 1,
            propertiesToFetch: [\.identifier, \.title]
        )
        Logger.entityQueries.info("Found \(projects.map(\.title)) projects")

        return projects.map(ProjectEntity.init(from:))
    }

    func suggestedEntities() async throws -> [ProjectEntity] {
        let store = WidgetStore()

        Logger.entityQueries.info("Loading projects to suggest for specific project...")
        let projects: [Project] = try store.models(propertiesToFetch: [\.identifier, \.title])
        Logger.entityQueries.info("Found \(projects.map(\.title)) projects")
        
        return projects.map(ProjectEntity.init(from:))
    }
}
