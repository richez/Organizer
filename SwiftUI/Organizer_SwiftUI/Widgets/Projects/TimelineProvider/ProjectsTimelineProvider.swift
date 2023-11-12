//
//  ProjectsTimelineProvider.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import OSLog
import WidgetKit

struct ProjectsTimelineProvider: AppIntentTimelineProvider {
    var store: WidgetStore = .init()

    func placeholder(in context: Context) -> ProjectsEntry {
        return self.entry(family: context.family)
    }

    func snapshot(for configuration: ProjectsIntent, in context: Context) async -> ProjectsEntry {
        Logger.timelineProviders.info("""
       Finding projects for widget snapshot with type \(configuration.type.rawValue) and \
       theme \(configuration.theme?.name ?? "nil")
       """)
        let entry = self.entry(for: configuration, family: context.family)
        Logger.timelineProviders.info("Found \(entry.projects?.map(\.title) ?? [])")

        return entry
    }

    func timeline(for configuration: ProjectsIntent, in context: Context) async -> Timeline<ProjectsEntry> {
        Logger.timelineProviders.info("""
       Finding projects for widget timeline with type \(configuration.type.rawValue) and \
       theme \(configuration.theme?.name ?? "nil")
       """)
        let entry = self.entry(for: configuration, family: context.family)
        Logger.timelineProviders.info("Found \(entry.projects?.map(\.title) ?? [])")

        return Timeline(entries: [entry], policy: .never)
    }
}

private extension ProjectsTimelineProvider {
    func entry(for configuration: ProjectsIntent? = nil, family: WidgetFamily) -> ProjectsEntry {
        let requiredCapacity = self.requiredCapacity(for: family)
        let projects = self.projects(for: configuration, fetchLimit: requiredCapacity)
        return ProjectsEntry(projects: projects, requiredCapacity: requiredCapacity)
    }

    func requiredCapacity(for family: WidgetFamily) -> Int {
        switch family {
        #if !os(macOS)
        case .accessoryCircular, .accessoryRectangular: 1
        #endif
        case .systemSmall: 1
        case .systemMedium: 2
        case .systemLarge: 5
        default: 0
        }
    }

    func projects(for configuration: ProjectsIntent?, fetchLimit: Int) -> [Project]? {
        do {
            let projects: [Project] = try self.store.models(
                predicate: self.predicate(for: configuration),
                sortBy: [.init(\.updatedDate, order: .reverse)],
                fetchLimit: fetchLimit,
                propertiesToFetch: [\.identifier, \.title, \.theme],
                relationshipKeyPathsForPrefetching: [\.contents]
            )
            return projects.isEmpty ? nil : projects
        } catch {
            Logger.timelineProviders.info("Fail to retrieve projects: \(error)")
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
