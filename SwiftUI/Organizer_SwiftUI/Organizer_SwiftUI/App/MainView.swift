//
//  MainView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftUI

struct MainView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
        NavigationSplitView(columnVisibility: self.$columnVisibility) {
            ProjectView()
        } detail: {
            ContentUnavailableView("Select Project", systemImage: "filemenu.and.selection")
                .foregroundStyle(.white)
                .background(.listBackground)
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    ModelContainerPreview {
        MainView()
    }
}
