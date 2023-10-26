//
//  AddProjectTimeline.swift
//  WidgetsExtension
//
//  Created by Thibaut Richez on 26/10/2023.
//

import WidgetKit

struct AddProjectTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> AddProjectEntry {
        AddProjectEntry()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (AddProjectEntry) -> Void) {
        completion(AddProjectEntry())
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<AddProjectEntry>) -> Void) {
        let entry = AddProjectEntry()
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}
