//
//  ProjectsWidgetConfiguration.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import WidgetKit

enum ProjectsWidgetConfiguration {
    static func numberOfProject(for family: WidgetFamily) -> Int {
        switch family {
        #if !os(macOS)
        case .accessoryCircular, .accessoryRectangular: 1
        #endif
        case .systemSmall: 1
        case .systemMedium: 2
        case .systemLarge: 5
        default: 0
        }
    }
}
