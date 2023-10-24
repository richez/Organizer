//
//  MainView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftUI

struct MainView: View {
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
        .environment(self.navigationContext)
        .navigationSplitViewStyle(.balanced)
        .fullScreenCover(item: $navigationContext.selectedContentURL) { url in
            SafariView(url: url)
                .ignoresSafeArea()
        }
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
