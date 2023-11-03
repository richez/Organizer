//
//  ProjectsTimelineProvider.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import OSLog
import WidgetKit

private let logger = Logger(subsystem: "Widgets", category: "ProjectsTimelineProvider")

struct ProjectsTimelineProvider: AppIntentTimelineProvider {
    var store: WidgetStore = .init()

    func placeholder(in context: Context) -> ProjectsEntry {
        let projects = self.projects(for: nil, widgetFamily: context.family)
        return ProjectsEntry(projects: projects)
    }
    
    func snapshot(for configuration: ProjectsIntent, in context: Context) async -> ProjectsEntry {
        logger.info("Finding projects for widget snapshot with type \(configuration.type.rawValue) and theme \(configuration.theme?.name ?? "nil")")
        let projects = self.projects(for: configuration, widgetFamily: context.family)
        logger.info("Found \(projects ?? [])")

        return ProjectsEntry(projects: projects)
    }
    
    func timeline(for configuration: ProjectsIntent, in context: Context) async -> Timeline<ProjectsEntry> {
        logger.info("Finding projects for widget timeline with type \(configuration.type.rawValue) and theme \(configuration.theme?.name ?? "nil")")
        let projects = self.projects(for: configuration, widgetFamily: context.family)
        logger.info("Found \(projects ?? [])")

        let entry = ProjectsEntry(projects: projects)
        return Timeline(entries: [entry], policy: .never)
    }
}

private extension ProjectsTimelineProvider {
    func projects(for configuration: ProjectsIntent?, widgetFamily: WidgetFamily) -> [Project]? {
        do {
            let predicate = self.predicate(for: configuration)
            let fetchLimit = ProjectsWidgetConfiguration.numberOfProject(for: widgetFamily)

            let projects = try self.store.projects(
                predicate: predicate,
                sortBy: [.init(\.updatedDate, order: .reverse)],
                fetchLimit: fetchLimit,
                propertiesToFetch: [\.title, \.theme],
                relationshipKeyPathsForPrefetching: [\.contents]
            )
            return projects.isEmpty ? nil : projects
        } catch {
            logger.info("Fail to retrieve projects: \(error)")
            return nil
        }
    }

    func predicate(for configuration: ProjectsIntent?) -> Predicate<Project>? {
        switch (configuration?.type, configuration?.theme) {
        case (.some(.specific), .some(let themeEntity)):
            let theme = themeEntity.name
            return #Predicate { $0.theme.contains(theme) }
        default:
            return nil
        }
    }
}
