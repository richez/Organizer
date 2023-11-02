//
//  LastProjectTimelineProvider.swift
//  WidgetsExtension
//
//  Created by Thibaut Richez on 26/10/2023.
//

import WidgetKit
import OSLog

private let logger = Logger(subsystem: "Widgets", category: "LastProjectTimelineProvider")

struct LastProjectTimelineProvider: TimelineProvider {
    var store: WidgetStore = .init()

    func placeholder(in context: Context) -> LastProjectEntry {
        let project = self.lastUpdatedProject()
        return LastProjectEntry(project: project)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (LastProjectEntry) -> Void) {
        logger.info("Finding last updated project for widget snapshot")
        let project = self.lastUpdatedProject()
        logger.info("Found \(project?.title ?? "nil")")

        let entry = LastProjectEntry(project: project)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<LastProjectEntry>) -> Void) {
        logger.info("Finding last updated project for widget timeline")
        let project = self.lastUpdatedProject()
        logger.info("Found \(project?.title ?? "nil")")

        let entry = LastProjectEntry(project: project)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

private extension LastProjectTimelineProvider {
    func lastUpdatedProject() -> Project? {
        do {
            let projects = try self.store.projects(
                sortBy: [.init(\.updatedDate, order: .reverse)],
                fetchLimit: 1,
                propertiesToFetch: [\.title, \.theme],
                relationshipKeyPathsForPrefetching: [\.contents]
            )
            return projects.first
        } catch {
            print("Fail to retrieve projects: \(error)")
            return nil
        }
    }
}