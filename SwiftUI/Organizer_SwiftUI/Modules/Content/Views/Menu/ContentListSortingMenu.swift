//
//  ContentListSortingMenu.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ContentListSortingMenu: View {
    @AppStorage(.contentListSorting)
    private var sorting: ContentListSorting = .updatedDate

    @AppStorage(.contentListAscendingOrder)
    private var isAscendingOrder: Bool = true

    init(suiteName: String) {
        let defaults = UserDefaults(suiteName: suiteName)
        self._sorting.update(with: defaults, key: .contentListSorting)
        self._isAscendingOrder.update(with: defaults, key: .contentListAscendingOrder)
    }

    var body: some View {
        Menu("List Sorting", systemImage: "arrow.up.arrow.down") {
            Picker("Order", selection: self.$sorting) {
                ForEach(ContentListSorting.allCases) { sorting in
                    Text(sorting.name)
                        .tag(sorting)
                }
            }
            .labelsHidden()
            .pickerStyle(.inline)

            Toggle(self.ascendingOrderTitle, isOn: self.$isAscendingOrder)
        }
    }
}

private extension ContentListSortingMenu {
    var ascendingOrderTitle: LocalizedStringKey {
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
        ContentListSortingMenu(suiteName: "test")
    }
}
