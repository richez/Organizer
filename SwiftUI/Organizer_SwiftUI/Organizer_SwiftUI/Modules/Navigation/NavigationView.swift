//
//  NavigationView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 24/10/2023.
//

import SwiftUI

struct NavigationView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var selectedProject: Project?

    var body: some View {
        NavigationSplitView(columnVisibility: self.$columnVisibility) {
            ProjectView(selected: self.$selectedProject)
        } detail: {
            Group {
                if let selectedProject {
                    ContentView(project: selectedProject)
                } else {
                    ProjectUnavailableView()
                }
            }
            .background(.listBackground)
        }
    }
}

#Preview {
    ModelContainerPreview {
        NavigationView()
    }
}
