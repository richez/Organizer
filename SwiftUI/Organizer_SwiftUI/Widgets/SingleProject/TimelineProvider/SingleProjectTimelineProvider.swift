//
//  SingleProjectTimelineProvider.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import OSLog
import WidgetKit

private let logger = Logger(subsystem: "Widgets", category: "SingleProjectTimelineProvider")

struct SingleProjectTimelineProvider: AppIntentTimelineProvider {
    var store: WidgetStore = .init()

    func placeholder(in context: Context) -> SingleProjectEntry {
        return self.entry(for: nil, family: context.family)
    }

    func snapshot(for configuration: SingleProjectIntent, in context: Context) async -> SingleProjectEntry {
        logger.info("Finding project for widget snapshot with title \(configuration.project?.title ?? "")")
        let entry = self.entry(for: configuration, family: context.family)
        logger.info("Found \(entry.project?.title ?? "nil") with contents: \(entry.contents)")

        return entry
    }

    func timeline(for configuration: SingleProjectIntent, in context: Context) async -> Timeline<SingleProjectEntry> {
        logger.info("Finding project for widget timeline with title \(configuration.project?.title ?? "")")
        let entry = self.entry(for: configuration, family: context.family)
        logger.info("Found \(entry.project?.title ?? "nil") with contents: \(entry.contents)")

        return Timeline(entries: [entry], policy: .never)
    }
}

private extension SingleProjectTimelineProvider {
    func entry(for configuration: SingleProjectIntent?, family: WidgetFamily) -> SingleProjectEntry {
        let requiredCapacity = self.requiredCapacity(for: family)
        let project = self.project(for: configuration)
        let contents = self.contents(for: configuration, fetchLimit: requiredCapacity)
        return SingleProjectEntry(project: project, contents: contents, requiredCapacity: requiredCapacity)
    }

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
        do {
            let projects: [Project] = try self.store.models(
                predicate: self.predicate(for: configuration),
                sortBy: [.init(\.updatedDate, order: .reverse)],
                fetchLimit: 1,
                propertiesToFetch: [\.identifier, \.title, \.theme],
                relationshipKeyPathsForPrefetching: [\.contents]
            )
            return projects.first
        } catch {
            logger.info("Fail to retrieve projects: \(error)")
            return nil
        }
    }

    func predicate(for configuration: SingleProjectIntent?) -> Predicate<Project>? {
        guard let projectEntity = configuration?.project else { return nil }
        let projectID = projectEntity.id
        return #Predicate { $0.identifier == projectID }
    }

    func contents(for configuration: SingleProjectIntent?, fetchLimit: Int) -> [ProjectContent] {
        guard let projectEntity = configuration?.project else { return [] }

        do {
            let projectID = projectEntity.id
            return try self.store.models(
                predicate: #Predicate { $0.project?.identifier == projectID },
                sortBy: [.init(\.updatedDate, order: .reverse)],
                fetchLimit: fetchLimit,
                propertiesToFetch: [\.identifier, \.typeRawValue, \.title, \.theme]
            )
        } catch {
            logger.info("Fail to retrieve project (\(projectEntity.id)) contents: \(error)")
            return []
        }
    }
}
