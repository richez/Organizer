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
    private var selectedTheme: ContentListTheme = .all

    @AppStorage(.contentListSelectedType)
    private var selectedType: ContentListType = .all

    init(contentCount: Int, themes: [String], suiteName: String) {
        self.contentCount = contentCount
        self.themes = themes

        let defaults = UserDefaults(suiteName: suiteName)
        self._sorting = AppStorage(
            wrappedValue: .updatedDate, .contentListSorting, store: defaults
        )
        self._isAscendingOrder = AppStorage(
            wrappedValue: true, .contentListAscendingOrder, store: defaults
        )
        self._showTheme = AppStorage(
            wrappedValue: true, .contentListShowTheme, store: defaults
        )
        self._showType = AppStorage(
            wrappedValue: true, .contentListShowType, store: defaults
        )
        self._selectedTheme = AppStorage(
            wrappedValue: .all, .contentListSelectedTheme, store: defaults
        )
        self._selectedType = AppStorage(
            wrappedValue: .all, .contentListSelectedType, store: defaults
        )
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
                    Text(ContentListTheme.all.rawValue)
                        .tag(ContentListTheme.all)
                    ForEach(self.themes, id: \.self) { theme in
                        Text(theme)
                            .tag(ContentListTheme.custom(theme))
                    }
                }
            }

            Menu("Type", systemImage: "tray.full") {
                Picker("Type", selection: self.$selectedType) {
                    Text(ContentListType.all.rawValue)
                        .tag(ContentListType.all)
                    ForEach(ProjectContentType.allCases) { type in
                        Text(type.rawValue)
                            .tag(ContentListType.custom(type))
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
