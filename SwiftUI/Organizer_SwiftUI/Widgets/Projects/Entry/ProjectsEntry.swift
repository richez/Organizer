//
//  ProjectsEntry.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import WidgetKit

struct ProjectsEntry: TimelineEntry {
    var projects: [Project]
    var date: Date = .now
}
