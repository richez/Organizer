//
//  ProjectListMenu.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct ProjectListMenu: View {
    let projectCount: Int
    let themes: [String]

    var body: some View {
        Menu("Menu", systemImage: "slider.horizontal.3") {
            Text("\(self.projectCount) projects")

            ProjectListSortingMenu()

            ProjectListPreviewStyleMenu()

            ProjectListThemeMenu(themes: self.themes)
        }
    }
}

#Preview {
    ZStack {
        Color.listBackground.ignoresSafeArea()
        ProjectListMenu(projectCount: 4, themes: ["DIY"])
            .tint(.white)
    }
}
