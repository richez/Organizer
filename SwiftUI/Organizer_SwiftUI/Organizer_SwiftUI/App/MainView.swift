//
//  MainView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftUI

struct MainView: View {
    @State private var navigationContext = NavigationContext()

    var body: some View {
        NavigationSplitView(columnVisibility: self.$navigationContext.columnVisibility) {
            ProjectView()
        } detail: {
            if let project = self.navigationContext.selectedProject {
                ContentView(project: project)
            } else {
                ProjectUnavailableView()
            }
        }
        .environment(self.navigationContext)
        .navigationSplitViewStyle(.balanced)
        .background(.listBackground)
        .onOpenURL { url in
            guard let deeplink = Deeplink(url: url) else { return }
            print(deeplink)
            print(deeplink.url!)
        }
    }
}

#Preview {
    ModelContainerPreview {
        MainView()
    }
}
