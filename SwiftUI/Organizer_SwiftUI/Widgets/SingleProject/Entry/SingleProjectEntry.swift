//
//  SingleProjectEntry.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import WidgetKit

struct SingleProjectEntry: TimelineEntry {
    var project: Project?
    var date: Date = .now
}
