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
    @State private var selectedContent: ProjectContent?

    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationSplitView(columnVisibility: self.$columnVisibility) {
            ThemeListView()
        } content: {
            ProjectView(selected: self.$selectedProject)
        } detail: {
            Group {
                if let selectedProject {
                    ContentView(project: selectedProject, selected: self.$selectedContent)
                } else {
                    ProjectUnavailableView()
                }
            }
            .frame(minWidth: 300)
        }
        .onChange(of: self.selectedContent) {
            if let selectedContent {
                self.openURL(selectedContent.url)
                self.selectedContent = nil
            }
        }
    }
}

#Preview {
    ModelContainerPreview {
        NavigationView()
    }
}
