//
//  ProjectsWidget.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import SwiftUI
import WidgetKit

struct ProjectsWidget: Widget {
    var families: [WidgetFamily] {
        #if os(macOS)
        [.systemSmall, .systemMedium, .systemLarge]
        #else
        [.accessoryCircular, .accessoryRectangular, .systemSmall, .systemMedium, .systemLarge]
        #endif
    }

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: .projects,
            intent: ProjectsIntent.self,
            provider: ProjectsTimelineProvider()
        ) { entry in
            ProjectsEntryView(entry: entry)
        }
        .configurationDisplayName(for: .projects)
        .description(for: .projects)
        .supportedFamilies(self.families)
    }
}

#if !os(macOS)
#Preview("Circular", as: .accessoryCircular) {
    ProjectsWidget()
} timeline: {
    ProjectsEntry()
    ProjectsEntry(projects: [.preview])
}

#Preview("Rectangular", as: .accessoryRectangular) {
    ProjectsWidget()
} timeline: {
    ProjectsEntry()
    ProjectsEntry(projects: [.preview])
}
#endif

#Preview("Small", as: .systemSmall) {
    ProjectsWidget()
} timeline: {
    ProjectsEntry()
    ProjectsEntry(projects: [.preview])
}

#Preview("Medium", as: .systemMedium) {
    ProjectsWidget()
} timeline: {
    ProjectsEntry()
    ProjectsEntry(projects: [.preview], requiredCapacity: 2)
    ProjectsEntry(projects: [.preview, .preview])
}

#Preview("Large", as: .systemLarge) {
    ProjectsWidget()
} timeline: {
    ProjectsEntry()
    ProjectsEntry(projects: [.preview], requiredCapacity: 5)
    ProjectsEntry(projects: [.preview, .preview], requiredCapacity: 5)
    ProjectsEntry(projects: [.preview, .preview, .preview], requiredCapacity: 5)
    ProjectsEntry(projects: [.preview, .preview, .preview, .preview], requiredCapacity: 5)
    ProjectsEntry(projects: [.preview, .preview, .preview, .preview, .preview])
}
