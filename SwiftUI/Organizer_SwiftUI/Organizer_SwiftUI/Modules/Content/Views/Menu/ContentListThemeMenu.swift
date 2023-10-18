//
//  ContentListThemeMenu.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct ContentListThemeMenu: View {
    var themes: [String]

    @AppStorage(.contentListSelectedTheme)
    private var selectedTheme: String? = nil

    init(themes: [String], suiteName: String) {
        self.themes = themes

        let defaults = UserDefaults(suiteName: suiteName)
        self._selectedTheme.update(with: defaults, key: .contentListSelectedTheme)
    }

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
        ContentListThemeMenu(themes: ["Insulation"], suiteName: "test")
    }
}
