//
//  ContentListPreviewStyleMenu.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ContentListPreviewStyleMenu: View {
    @AppStorage(.contentListShowTheme)
    private var showTheme: Bool = true

    @AppStorage(.contentListShowType)
    private var showType: Bool = true

    init(suiteName: String) {
        let defaults = UserDefaults(suiteName: suiteName)
        self._showTheme.update(with: defaults, key: .contentListShowTheme)
        self._showType.update(with: defaults, key: .contentListShowType)
    }

    var body: some View {
        Menu("Preview Style", systemImage: "text.alignleft") {
            Toggle("Theme", isOn: self.$showTheme)
            Toggle("Type", isOn: self.$showType)
        }
    }
}

#Preview {
    ZStack {
        Color.listBackground.ignoresSafeArea()
        ContentListPreviewStyleMenu(suiteName: "test")
    }
}
