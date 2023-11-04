//
//  ProjectEntityQuery.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import AppIntents
import Foundation
import OSLog

private let logger = Logger(subsystem: "Widgets", category: "ProjectEntityQuery")

struct ProjectEntityQuery: EntityQuery {
    func entities(for identifiers: [ProjectEntity.ID]) async throws -> [ProjectEntity] {
        let store = WidgetStore()
        logger.info("Loading projects for identifiers: \(identifiers)")
        let projects = try store.projects(
            predicate: #Predicate { identifiers.contains($0.identifier) },
            fetchLimit: 1,
            propertiesToFetch: [\.identifier, \.title]
        )
        logger.info("Found \(projects.map(\.title)) projects")
        return projects.map(ProjectEntity.init(from:))
    }

    func suggestedEntities() async throws -> [ProjectEntity] {
        let store = WidgetStore()
        logger.info("Loading projects to suggest for specific project...")
        let projects = try store.projects(propertiesToFetch: [\.identifier, \.title])
        logger.info("Found \(projects.map(\.title)) projects")
        return projects.map(ProjectEntity.init(from:))
    }
}
