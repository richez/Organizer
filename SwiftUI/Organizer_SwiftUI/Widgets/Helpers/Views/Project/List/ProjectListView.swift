//
//  ProjectListView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import SwiftUI

struct ProjectListView: View {
    var projects: [Project]
    var placeholders: [Project]

    var body: some View {
        ContentContainerView(systemImage: "ellipsis") {
            ForEach(self.projects) { project in
                ProjectRow(project: project)
            }
            ForEach(self.placeholders) { project in
                ProjectRow(project: project)
                    .redacted(reason: .placeholder)
            }
        }
    }
}
