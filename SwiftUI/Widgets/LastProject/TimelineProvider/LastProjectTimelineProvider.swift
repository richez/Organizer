//
//  LastProjectTimelineProvider.swift
//  WidgetsExtension
//
//  Created by Thibaut Richez on 26/10/2023.
//

import WidgetKit
import OSLog

struct LastProjectTimelineProvider: TimelineProvider {
    var store: WidgetStore = .init()

    func placeholder(in context: Context) -> LastProjectEntry {
        return self.entry()
    }

    func getSnapshot(in context: Context, completion: @escaping (LastProjectEntry) -> Void) {
        Logger.timelineProviders.info("Finding last updated project for widget snapshot")
        let entry = self.entry()
        Logger.timelineProviders.info("Found \(entry.project?.title ?? "none")")

        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<LastProjectEntry>) -> Void) {
        Logger.timelineProviders.info("Finding last updated project for widget timeline")
        let entry = self.entry()
        Logger.timelineProviders.info("Found \(entry.project?.title ?? "none")")

        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

private extension LastProjectTimelineProvider {
    func entry() -> LastProjectEntry {
        let project = self.lastUpdatedProject()
        return LastProjectEntry(project: project)
    }

    func lastUpdatedProject() -> Project? {
        do {
            let projects: [Project] = try self.store.models(
                sortBy: [.init(\.updatedDate, order: .reverse)],
                fetchLimit: 1,
                propertiesToFetch: [\.identifier, \.title, \.theme],
                relationshipKeyPathsForPrefetching: [\.contents]
            )
            return projects.first
        } catch {
            Logger.timelineProviders.info("Fail to retrieve projects: \(error)")
            return nil
        }
    }
}
