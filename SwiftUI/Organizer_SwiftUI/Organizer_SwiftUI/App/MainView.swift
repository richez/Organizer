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
        .fullScreenCover(item: self.$navigationContext.selectedContentURL) { url in
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
