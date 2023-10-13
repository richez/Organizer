//
//  MainView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationSplitView {
            ProjectView()
        } detail: {
            Text("Select Project")
        }
    }
}

#Preview {
    MainView()
        .previewModelContainer()
}