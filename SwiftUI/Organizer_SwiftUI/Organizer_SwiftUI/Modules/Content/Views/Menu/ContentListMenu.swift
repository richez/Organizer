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

    @AppStorage(.contentListSorting)
    private var sorting: ContentListSorting = .updatedDate

    @AppStorage(.contentListAscendingOrder)
    private var isAscendingOrder: Bool = true

    @AppStorage(.contentListShowTheme)
    private var showTheme: Bool = true

    @AppStorage(.contentListShowType)
    private var showType: Bool = true

    @AppStorage(.contentListSelectedTheme)
    private var selectedTheme: String? = nil

    @AppStorage(.contentListSelectedType)
    private var selectedType: ProjectContentType?

    init(contentCount: Int, themes: [String], suiteName: String) {
        self.contentCount = contentCount
        self.themes = themes

        let defaults = UserDefaults(suiteName: suiteName)
        self._sorting.update(with: defaults, key: .contentListSorting)
        self._isAscendingOrder.update(with: defaults, key: .contentListAscendingOrder)
        self._showTheme.update(with: defaults, key: .contentListShowTheme)
        self._showType.update(with: defaults, key: .contentListShowType)
        self._selectedTheme.update(with: defaults, key: .contentListSelectedTheme)
        self._selectedType.update(with: defaults, key: .contentListSelectedType)
    }

    var body: some View {
        Menu("Menu", systemImage: "slider.horizontal.3") {
            Text("\(self.contentCount) contents")

            Menu("List Sorting", systemImage: "arrow.up.arrow.down") {
                Picker("List Sorting", selection: self.$sorting) {
                    ForEach(ContentListSorting.allCases) { sorting in
                        Text(sorting.rawValue)
                            .tag(sorting)
                    }
                }

                Toggle(self.ascendingOrderTitle, isOn: self.$isAscendingOrder)
            }

            Menu("Preview Style", systemImage: "text.alignleft") {
                Toggle("Theme", isOn: self.$showTheme)
                Toggle("Type", isOn: self.$showType)
            }

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
}

private extension ContentListMenu {
    var ascendingOrderTitle: String {
        switch self.sorting {
        case .title, .type:
            return "A to Z"
        case .updatedDate, .createdDate:
            return "Newest on Top"
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
