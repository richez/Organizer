//
//  ProjectsEntry.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import WidgetKit

struct ProjectsEntry: TimelineEntry {
    var projects: [Project]?
    /// Defines the number of content the widget is able to display.
    /// If the project array doesn't have enough elements, this
    /// number is used to display placeholders.
    var requiredCapacity: Int = 0
    var date: Date = .now
}
