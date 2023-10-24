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
    @State private var selectedContent: ProjectContent?

    var body: some View {
        NavigationSplitView(columnVisibility: self.$columnVisibility) {
            ProjectView(selected: self.$selectedProject)
        } detail: {
            Group {
                if let selectedProject {
                    ContentView(project: selectedProject, selected: self.$selectedContent)
                } else {
                    ProjectUnavailableView()
                }
            }
            .background(.listBackground)
        }
        .fullScreenCover(item: self.$selectedContent) { content in
            SafariView(url: content.url)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ModelContainerPreview {
        NavigationView()
    }
}
