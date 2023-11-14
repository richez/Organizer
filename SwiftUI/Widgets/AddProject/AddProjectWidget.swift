//
//  AddProjectWidget.swift
//  WidgetsExtension
//
//  Created by Thibaut Richez on 26/10/2023.
//

import SwiftUI
import WidgetKit

struct AddProjectWidget: Widget {
    var families: [WidgetFamily] {
        #if os(macOS)
        [.systemSmall]
        #else
        [.accessoryCircular, .systemSmall]
        #endif
    }

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: .addProject,
            provider: AddProjectTimelineProvider()) { _ in
                AddProjectEntryView()
            }
            .configurationDisplayName(for: .addProject)
            .description(for: .addProject)
            .supportedFamilies(self.families)
    }
}

#if !os(macOS)
#Preview("Circular", as: .accessoryCircular) {
    AddProjectWidget()
} timeline: {
    AddProjectEntry()
}
#endif

#Preview("Small", as: .systemSmall) {
    AddProjectWidget()
} timeline: {
    AddProjectEntry()
}
