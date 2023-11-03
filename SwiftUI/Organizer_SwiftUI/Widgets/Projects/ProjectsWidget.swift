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
        ) { _ in
            ProjectsEntryView()
        }
    }
}
