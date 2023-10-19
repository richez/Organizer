//
//  MainView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct MainView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
        NavigationSplitView(columnVisibility: self.$columnVisibility) {
            ThemeListView()
        } content: {
            ProjectView()
        } detail: {
            ContentUnavailableView {
                VStack(spacing: 20) {
                    Image(systemName: "filemenu.and.selection")
                    Text("Select a project")
                }
                .font(.largeTitle)
                .foregroundStyle(.white)
                .background(.listBackground)
            }
        }
        .navigationSplitViewStyle(.balanced)
        .background(.listBackground)
    }
}

#Preview {
    ModelContainerPreview {
        MainView()
    }
}
