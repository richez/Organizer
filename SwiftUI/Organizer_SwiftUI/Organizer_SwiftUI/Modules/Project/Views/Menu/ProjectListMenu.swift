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

    @AppStorage(.projectListSorting)
    private var sorting: ProjectListSorting = .updatedDate

    @AppStorage(.projectListAscendingOrder)
    private var isAscendingOrder: Bool = true

    @AppStorage(.projectListShowTheme)
    private var showTheme: Bool = true

    @AppStorage(.projectListShowStatistics)
    private var showStatistics: Bool = true

    @AppStorage(.projectListSelectedTheme)
    private var selectedTheme: ProjectListTheme = .all

    var body: some View {
        Menu("Menu", systemImage: "slider.horizontal.3") {
            Text("\(self.projectCount) projects")

            Menu("List Sorting", systemImage: "arrow.up.arrow.down") {
                Picker("List Sorting", selection: self.$sorting) {
                    ForEach(ProjectListSorting.allCases) { sorting in
                        Text(sorting.rawValue)
                            .tag(sorting)
                    }
                }

                Toggle(self.ascendingOrderTitle, isOn: self.$isAscendingOrder)
            }

            Menu("Preview Style", systemImage: "text.alignleft") {
                Toggle("Theme", isOn: self.$showTheme)
                Toggle("Statistics", isOn: self.$showStatistics)
            }

            Menu("Themes", systemImage: "number") {
                Picker("Themes", selection: self.$selectedTheme) {
                    Text(ProjectListTheme.all.rawValue)
                        .tag(ProjectListTheme.all)
                    ForEach(self.themes, id: \.self) { theme in
                        Text(theme)
                            .tag(ProjectListTheme.custom(theme))
                    }
                }
            }
        }
    }
}

extension ProjectListMenu {
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
        ProjectListMenu(projectCount: 4, themes: ["DIY"])
            .tint(.white)
    }
}
