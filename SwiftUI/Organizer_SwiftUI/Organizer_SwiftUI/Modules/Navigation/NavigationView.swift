//
//  NavigationView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 24/10/2023.
//

import SwiftUI

struct NavigationView: View {
    @Environment(NavigationContext.self) private var navigationContext

    var body: some View {
        @Bindable var navigationContext = self.navigationContext
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            ProjectView()
        } detail: {
            Group {
                if let project = self.navigationContext.selectedProject {
                    ContentView(project: project)
                } else {
                    ProjectUnavailableView()
                }
            }
            .background(.listBackground)
        }
        .fullScreenCover(item: $navigationContext.selectedContent) { content in
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
