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
            provider: LastProjectTimelineProvider()) { _ in
                LastProjectEntryView()
            }
            .configurationDisplayName(for: .lastProject)
            .description(for: .lastProject)
            .supportedFamilies(self.families)
    }
}
