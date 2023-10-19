//
//  ProjectListSortingMenu.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectListSortingMenu: View {
    @AppStorage(.projectListSorting)
    private var sorting: ProjectListSorting = .updatedDate

    @AppStorage(.projectListAscendingOrder)
    private var isAscendingOrder: Bool = true

    var body: some View {
        Menu("List Sorting", systemImage: "arrow.up.arrow.down") {
            Picker("Order", selection: self.$sorting) {
                ForEach(ProjectListSorting.allCases) { sorting in
                    Text(sorting.rawValue)
                        .tag(sorting)
                }
            }
            .labelsHidden()
            .pickerStyle(.inline)

            Toggle(self.ascendingOrderTitle, isOn: self.$isAscendingOrder)
        }
    }
}

private extension ProjectListSortingMenu {
    var ascendingOrderTitle: String {
        switch self.sorting {
        case .title:
            return "A to Z"
        case .updatedDate, .createdDate:
            return "Newest on Top"
        }
    }
}

#Preview {
    ZStack {
        Color.listBackground.ignoresSafeArea()
        ProjectListSortingMenu()
    }
}
