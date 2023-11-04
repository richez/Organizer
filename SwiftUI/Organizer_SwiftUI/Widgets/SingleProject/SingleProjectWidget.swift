//
//  SingleProjectWidget.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import SwiftUI
import WidgetKit

struct SingleProjectWidget: Widget {
    var families: [WidgetFamily] {
        #if os(macOS)
        [.systemSmall, .systemMedium, .systemLarge]
        #else
        [.accessoryCircular, .accessoryRectangular, .systemSmall, .systemMedium, .systemLarge]
        #endif
    }

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: .singleProject,
            intent: SingleProjectIntent.self,
            provider: SingleProjectTimelineProvider()
        ) { _ in
            SingleProjectEntryView()
        }
        .configurationDisplayName(for: .singleProject)
        .description(for: .singleProject)
        .supportedFamilies(self.families)
    }
}
