//
//  NavigationView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct NavigationView: View {
    @Binding var navigationContext: NavigationContext

    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationSplitView(columnVisibility: self.$navigationContext.columnVisibility) {
            ThemeListView()
        } content: {
            ProjectView(
                selectedProject: self.$navigationContext.selectedProject,
                isShowingForm: self.$navigationContext.isShowingProjectForm
            )
        } detail: {
            Group {
                if let project = self.navigationContext.selectedProject {
                    ContentView(project: project, selected: self.$navigationContext.selectedContent)
                } else {
                    ProjectUnavailableView()
                }
            }
            .frame(minWidth: 300)
        }
        .onChange(of: self.navigationContext.selectedContent) {
            if let content = self.navigationContext.selectedContent {
                self.openURL(content.url)
                self.navigationContext.selectedContent = nil
            }
        }
    }
}

#Preview {
    ModelContainerPreview {
        NavigationView(navigationContext: .constant(NavigationContext()))
    }
}
