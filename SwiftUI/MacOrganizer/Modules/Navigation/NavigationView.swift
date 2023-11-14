//
//  NavigationView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct NavigationView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.openURL) private var openURL

    var body: some View {
        @Bindable var navigationContext = self.navigationContext
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            ThemeListView()
        } content: {
            ProjectView()
        } detail: {
            Group {
                if let project = self.navigationContext.selectedProject {
                    ContentView(project: project)
                } else {
                    ProjectUnavailableView()
                }
            }
            .frame(minWidth: 300)
        }
        .onChange(of: self.navigationContext.selectedContent) { _, selectedContent in
            if let selectedContent {
                self.openURL(selectedContent.url)
                self.navigationContext.selectedContent = nil
            }
        }
    }
}

#Preview {
    ModelContainerPreview {
        NavigationView()
            .background(.listBackground)
    }
}
