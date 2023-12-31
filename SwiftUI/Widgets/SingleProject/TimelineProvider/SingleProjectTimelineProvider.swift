//
//  SingleProjectTimelineProvider.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import OSLog
import WidgetKit

struct SingleProjectTimelineProvider: AppIntentTimelineProvider {
    var store: WidgetStore = .init()

    func placeholder(in context: Context) -> SingleProjectEntry {
        return self.entry(family: context.family)
    }

    func snapshot(for configuration: SingleProjectIntent, in context: Context) async -> SingleProjectEntry {
        Logger.timelineProviders.info("""
       Finding project for widget snapshot with title \(configuration.project?.title ?? "none")
       """)
        let entry = self.entry(for: configuration, family: context.family)
        Logger.timelineProviders.info("""
       Found \(entry.project?.title ?? "none") with contents: \(entry.contents.map(\.title))
       """)

        return entry
    }

    func timeline(for configuration: SingleProjectIntent, in context: Context) async -> Timeline<SingleProjectEntry> {
        Logger.timelineProviders.info("""
       Finding project for widget timeline with title \(configuration.project?.title ?? "none")
       """)
        let entry = self.entry(for: configuration, family: context.family)
        Logger.timelineProviders.info("""
       Found \(entry.project?.title ?? "none") with contents: \(entry.contents.map(\.title))
       """)

        return Timeline(entries: [entry], policy: .never)
    }
}

private extension SingleProjectTimelineProvider {
    func entry(for configuration: SingleProjectIntent? = nil, family: WidgetFamily) -> SingleProjectEntry {
        let requiredCapacity = self.requiredCapacity(for: family)
        let project = self.project(for: configuration)
        let contents = self.contents(for: project, fetchLimit: requiredCapacity)
        return SingleProjectEntry(project: project, contents: contents, requiredCapacity: requiredCapacity)
    }

    /// Returns the number of elements the widget needs.
    func requiredCapacity(for family: WidgetFamily) -> Int {
        switch family {
        #if !os(macOS)
        case .accessoryCircular, .accessoryRectangular: 0
        #endif
        case .systemSmall: 0
        case .systemMedium: 2
        case .systemLarge: 5
        default: 0
        }
    }

    func project(for configuration: SingleProjectIntent?) -> Project? {
        guard let projectEntity = configuration?.project else { return nil }

        do {
            let projectID = projectEntity.id
            let projects: [Project] = try self.store.models(
                predicate: #Predicate { $0.identifier == projectID },
                sortBy: [.init(\.updatedDate, order: .reverse)],
                fetchLimit: 1,
                propertiesToFetch: [\.identifier, \.title, \.theme]
            )
            return projects.first
        } catch {
            Logger.timelineProviders.info("Fail to retrieve projects: \(error)")
            return nil
        }
    }

    func contents(for project: Project?, fetchLimit: Int) -> [ProjectContent] {
        guard let project else { return [] }

        do {
            let projectID = project.identifier
            return try self.store.models(
                predicate: #Predicate { $0.project?.identifier == projectID },
                sortBy: [.init(\.updatedDate, order: .reverse)],
                fetchLimit: fetchLimit,
                propertiesToFetch: [\.identifier, \.typeRawValue, \.title, \.theme]
            )
        } catch {
            Logger.timelineProviders.info("Fail to retrieve project (\(project.identifier)) contents: \(error)")
            return []
        }
    }
}
