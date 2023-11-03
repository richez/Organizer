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
        logger.info("Found \(projects)")

        return ProjectsEntry(projects: projects)
    }
    
    func timeline(for configuration: ProjectsIntent, in context: Context) async -> Timeline<ProjectsEntry> {
        logger.info("Finding projects for widget timeline with type \(configuration.type.rawValue) and theme \(configuration.theme?.name ?? "nil")")
        let projects = self.projects(for: configuration, widgetFamily: context.family)
        logger.info("Found \(projects)")

        let entry = ProjectsEntry(projects: projects)
        return Timeline(entries: [entry], policy: .never)
    }
}

private extension ProjectsTimelineProvider {
    func projects(for configuration: ProjectsIntent?, widgetFamily: WidgetFamily) -> [Project] {
        do {
            return try self.store.projects(
                predicate: self.predicate(for: configuration),
                sortBy: [.init(\.updatedDate, order: .reverse)],
                fetchLimit: self.fetchLimit(for: widgetFamily),
                propertiesToFetch: [\.title, \.theme],
                relationshipKeyPathsForPrefetching: [\.contents]
            )
        } catch {
            print("Fail to retrieve projects: \(error)")
            return []
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

    func fetchLimit(for family: WidgetFamily) -> Int {
        switch family {
        #if !os(macOS)
        case .accessoryCircular, .accessoryRectangular: 1
        #endif
        case .systemSmall: 1
        case .systemMedium: 3
        case .systemLarge: 5
        default: 0
        }
    }
}
