//
//  SingleProjectWidget.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import SwiftUI
import WidgetKit

// TODO: fix empty project message
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
        ) { entry in
            SingleProjectEntryView(entry: entry)
        }
        .configurationDisplayName(for: .singleProject)
        .description(for: .singleProject)
        .supportedFamilies(self.families)
    }
}

#if !os(macOS)
#Preview("Circular", as: .accessoryCircular) {
    SingleProjectWidget()
} timeline: {
    SingleProjectEntry()
    SingleProjectEntry(project: .preview)
}

#Preview("Rectangular", as: .accessoryRectangular) {
    SingleProjectWidget()
} timeline: {
    SingleProjectEntry()
    SingleProjectEntry(project: .preview)
}
#endif

#Preview("Small", as: .systemSmall) {
    SingleProjectWidget()
} timeline: {
    SingleProjectEntry()
    SingleProjectEntry(project: .preview)
}

#Preview("Medium", as: .systemMedium) {
    SingleProjectWidget()
} timeline: {
    SingleProjectEntry()
    SingleProjectEntry(project: .preview, requiredCapacity: 2)
    SingleProjectEntry(project: .preview, contents: [.preview], requiredCapacity: 2)
    SingleProjectEntry(project: .preview, contents: [.preview, .preview])
}

#Preview("Large", as: .systemLarge) {
    SingleProjectWidget()
} timeline: {
    SingleProjectEntry()
    SingleProjectEntry(project: .preview, requiredCapacity: 5)
    SingleProjectEntry(project: .preview, contents: [.preview], requiredCapacity: 5)
    SingleProjectEntry(project: .preview, contents: [.preview, .preview], requiredCapacity: 5)
    SingleProjectEntry(project: .preview, contents: [.preview, .preview, .preview], requiredCapacity: 5)
    SingleProjectEntry(project: .preview, contents: [.preview, .preview, .preview, .preview], requiredCapacity: 5)
    SingleProjectEntry(project: .preview, contents: [.preview, .preview, .preview, .preview, .preview])
}
