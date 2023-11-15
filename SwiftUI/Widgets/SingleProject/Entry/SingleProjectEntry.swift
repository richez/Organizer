//
//  SingleProjectEntry.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import WidgetKit

struct SingleProjectEntry: TimelineEntry {
    var project: Project?
    var contents: [ProjectContent] = []
    /// Defines the number of content the widget is able to display.
    /// If the content array doesn't have enough elements, this
    /// number is used to display placeholders.
    var requiredCapacity: Int = 0
    var date: Date = .now
}
