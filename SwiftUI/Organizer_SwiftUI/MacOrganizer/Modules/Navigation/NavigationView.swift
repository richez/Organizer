//
//  NavigationView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct NavigationView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var selectedProject: Project?

    var body: some View {
        NavigationSplitView(columnVisibility: self.$columnVisibility) {
            ThemeListView()
        } content: {
            ProjectView(selected: self.$selectedProject)
        } detail: {
            Group {
                if let selectedProject {
                    ContentView(project: selectedProject)
                } else {
                    ProjectUnavailableView()
                }
            }
            .frame(minWidth: 300)
        }
    }
}

#Preview {
    ModelContainerPreview {
        NavigationView()
    }
}
