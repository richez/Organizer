//
//  ProjectListThemeMenu.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectListThemeMenu: View {
    let themes: [String]

    @AppStorage(.projectListSelectedTheme)
    private var selectedTheme: String? = nil

    var body: some View {
        Menu("Themes", systemImage: "number") {
            Picker("Themes", selection: self.$selectedTheme) {
                Text("All")
                    .tag(nil as String?)
                ForEach(self.themes, id: \.self) { theme in
                    Text(theme)
                        .tag(theme as String?)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.listBackground.ignoresSafeArea()
        ProjectListThemeMenu(themes: ["DIY"])
    }
}
