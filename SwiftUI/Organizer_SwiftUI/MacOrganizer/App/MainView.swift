//
//  MainView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct MainView: View {
    @State private var navigationContext = NavigationContext()

    var body: some View {
        NavigationSplitView(columnVisibility: self.$navigationContext.columnVisibility) {
            ThemeListView()
        } content: {
            ProjectView()
        } detail: {
            if let project = self.navigationContext.selectedProject {
                ContentView(project: project)
                    .frame(minWidth: 300)
            } else {
                ProjectUnavailableView()
                    .frame(minWidth: 300)
            }
        }
        .environment(self.navigationContext)
        .focusedValue(\.selectedProject, self.$navigationContext.selectedProject)
        .navigationSplitViewStyle(.balanced)
        .background(.listBackground)
    }
}

#Preview {
    ModelContainerPreview {
        MainView()
    }
}
