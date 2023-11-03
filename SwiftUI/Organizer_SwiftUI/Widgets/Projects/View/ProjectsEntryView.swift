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
                EmptyProjectView()
            }
        }
        .containerBackground(for: .widget) {
            Color.listBackground
        }
    }
}

private extension ProjectsEntryView {
    var placeholders: [Project] {
        let count = self.entry.projects?.count ?? 0
        let requiredCapacity = ProjectsWidgetConfiguration.numberOfProject(for: self.widgetFamily)
        if count < requiredCapacity {
            return [Project](repeating: .preview, count: requiredCapacity - count)
        } else {
            return []
        }
    }
}
