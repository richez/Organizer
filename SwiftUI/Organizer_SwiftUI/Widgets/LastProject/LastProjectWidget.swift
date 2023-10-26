//
//  LastProjectWidget.swift
//  WidgetsExtension
//
//  Created by Thibaut Richez on 26/10/2023.
//

import SwiftUI
import WidgetKit

struct LastProjectWidget: Widget {
    var families: [WidgetFamily] {
        #if os(macOS)
        [.systemSmall]
        #else
        [.accessoryCircular, .accessoryRectangular, .systemSmall]
        #endif
    }

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: .lastProject,
            provider: LastProjectTimelineProvider()) { entry in
                LastProjectEntryView(entry: entry)
            }
            .configurationDisplayName(for: .lastProject)
            .description(for: .lastProject)
            .supportedFamilies(self.families)
    }
}

#if !os(macOS)
#Preview("Circular", as: .accessoryCircular) {
    LastProjectWidget()
 } timeline: {
     LastProjectEntry()
 }

#Preview("Rectangular", as: .accessoryRectangular) {
    LastProjectWidget()
 } timeline: {
     LastProjectEntry()
 }
#endif

#Preview("Small", as: .systemSmall) {
    LastProjectWidget()
 } timeline: {
     LastProjectEntry()
     LastProjectEntry(project: .preview)
 }
