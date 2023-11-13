//
//  ProjectsEntryView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import SwiftUI

struct ProjectsEntryView: View {
    var entry: ProjectsEntry

    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        Group {
            if let projects = self.entry.projects {
                switch self.widgetFamily {
                #if !os(macOS)
                case .accessoryCircular, .accessoryRectangular:
                    ProjectView(project: projects.first!)
                #endif
                case .systemSmall:
                    ProjectView(project: projects.first!)
                default:
                    ProjectListView(projects: projects, placeholders: self.placeholders)
                }
            } else {
                EmptyProjectView(kind: .projects)
            }
        }
        .containerBackground(for: .widget) {
            Color.listBackground
        }
    }
}

private extension ProjectsEntryView {
    var placeholders: Int {
        guard let count = self.entry.projects?.count else { return 0 }
        let requiredCapacity = self.entry.requiredCapacity
        return count < requiredCapacity ? requiredCapacity - count : 0
    }
}
