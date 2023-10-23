//
//  MainView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftUI

struct MainView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var selectedProject: Project?

    var body: some View {
        NavigationSplitView(columnVisibility: self.$columnVisibility) {
            ProjectView(selected: self.$selectedProject)
        } detail: {
            if let selectedProject {
                ContentView(project: selectedProject)
            } else {
                ProjectUnavailableView()
            }
        }
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
