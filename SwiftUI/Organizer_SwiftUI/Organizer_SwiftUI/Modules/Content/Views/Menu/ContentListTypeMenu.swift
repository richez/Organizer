//
//  ContentListTypeMenu.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct ContentListTypeMenu: View {
    @AppStorage(.contentListSelectedType)
    private var selectedType: ProjectContentType?

    init(suiteName: String) {
        let defaults = UserDefaults(suiteName: suiteName)
        self._selectedType.update(with: defaults, key: .contentListSelectedType)
    }

    var body: some View {
        Menu("Type", systemImage: "tray.full") {
            Picker("Type", selection: self.$selectedType) {
                Text("All")
                    .tag(nil as ProjectContentType?)
                ForEach(ProjectContentType.allCases) { type in
                    Text(type.rawValue)
                        .tag(type as ProjectContentType?)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.listBackground.ignoresSafeArea()
        ContentListTypeMenu(suiteName: "test")
    }
}
