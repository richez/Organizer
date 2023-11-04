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
        SingleProjectEntry()
    }
    
    func snapshot(for configuration: SingleProjectIntent, in context: Context) async -> SingleProjectEntry {
        SingleProjectEntry()
    }
    
    func timeline(for configuration: SingleProjectIntent, in context: Context) async -> Timeline<SingleProjectEntry> {
        let entry = SingleProjectEntry()
        return Timeline(entries: [entry], policy: .never)
    }
}
