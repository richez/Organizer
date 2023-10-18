//
//  ContentListMenu.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

struct ContentListMenu: View {
    let contentCount: Int
    let themes: [String]
    let suiteName: String

    var body: some View {
        Menu("Menu", systemImage: "slider.horizontal.3") {
            Text("\(self.contentCount) contents")

            ContentListSortingMenu(suiteName: self.suiteName)

            ContentListPreviewStyleMenu(suiteName: self.suiteName)

            ContentListThemeMenu(themes: self.themes, suiteName: self.suiteName)

            ContentListTypeMenu(suiteName: self.suiteName)
        }
    }
}

#Preview {
    ZStack {
        Color.listBackground.ignoresSafeArea()
        ContentListMenu(
            contentCount: 4, themes: ["Insulation"], suiteName: "test"
        )
    }
}
