//
//  SingleProjectEntryView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import SwiftUI

struct SingleProjectEntryView: View {
    var entry: SingleProjectEntry

    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        Group {
            if let project = self.entry.project {
                switch self.widgetFamily {
                #if !os(macOS)
                case .accessoryCircular, .accessoryRectangular:
                    ProjectView(project: project)
                #endif
                case .systemSmall:
                    ProjectView(project: project)
                default:
                    EmptyView() // TODO: add custom view
                }
            } else {
                EmptyProjectView()
            }
        }
        .containerBackground(for: .widget) {
            Color.listBackground
        }
    }
}
