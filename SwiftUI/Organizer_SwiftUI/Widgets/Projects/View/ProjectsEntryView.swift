//
//  ProjectsEntryView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import SwiftUI

struct ProjectsEntryView: View {
    var entry: ProjectsEntry

    var body: some View {
        Group {
            if let project = self.entry.projects?.first {
                ProjectView(project: project)
            } else {
                EmptyProjectView()
            }
        }
        .containerBackground(for: .widget) {
            Color.listBackground
        }
    }
}
