//
//  LastProjectTimelineProvider.swift
//  WidgetsExtension
//
//  Created by Thibaut Richez on 26/10/2023.
//

import WidgetKit

struct LastProjectTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> LastProjectEntry {
        LastProjectEntry()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (LastProjectEntry) -> Void) {
        let entry = LastProjectEntry()
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<LastProjectEntry>) -> Void) {
        let entry = LastProjectEntry()
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}
