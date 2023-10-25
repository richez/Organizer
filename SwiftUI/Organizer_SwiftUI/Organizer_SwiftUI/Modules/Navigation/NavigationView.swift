//
//  NavigationView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 24/10/2023.
//

import SwiftUI

struct NavigationView: View {
    @Binding var navigationContext: NavigationContext

    var body: some View {
        NavigationSplitView(columnVisibility: self.$navigationContext.columnVisibility) {
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
            .background(.listBackground)
        }
        .fullScreenCover(item: self.$navigationContext.selectedContent) { content in
            SafariView(url: content.url)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ModelContainerPreview {
        NavigationView(navigationContext: .constant(NavigationContext()))
    }
}
