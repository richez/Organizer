//
//  MainView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct MainView: View {
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
        .environment(self.navigationContext)
        .focusedValue(\.selectedProject, $navigationContext.selectedProject)
        .navigationSplitViewStyle(.balanced)
        .background(.listBackground)
        .onChange(of: self.navigationContext.selectedContentURL) {
            if let url = self.navigationContext.selectedContentURL {
                self.openURL(url)
                self.navigationContext.selectedContentURL = nil
            }
        }
    }
}

#Preview {
    ModelContainerPreview {
        MainView()
    }
}
