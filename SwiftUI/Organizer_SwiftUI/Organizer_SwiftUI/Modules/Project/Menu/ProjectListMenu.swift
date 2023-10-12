//
//  ProjectListMenu.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct ProjectListMenu: View {
    let projectCount: Int
    let themes: [ProjectListTheme]

    private let viewModel = ViewModel()

    @AppStorage(StorageKey.projectListSorting.rawValue)
    private var sorting: ProjectListSorting = .updatedDate

    @AppStorage(StorageKey.projectListAscendingOrder.rawValue)
    private var isAscendingOrder: Bool = true

    @AppStorage(StorageKey.projectListShowTheme.rawValue)
    private var showTheme: Bool = true

    @AppStorage(StorageKey.projectListShowStatistics.rawValue)
    private var showStatistics: Bool = true

    @AppStorage(StorageKey.projectListSelectedTheme.rawValue)
    private var selectedTheme: ProjectListTheme = .all

    var body: some View {
        Menu("Menu", systemImage: "ellipsis") {
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
                    ForEach(self.themes) { theme in
                        Text(theme.rawValue)
                            .tag(theme)
                    }
                }
            }
        }
    }
}

extension ProjectListMenu {
    struct ViewModel {
        func ascendingOrderTitle(for sorting: ProjectListSorting) -> String {
            switch sorting {
            case .title:
                return "A to Z"
            case .updatedDate, .createdDate:
                return "Newest on Top"
            }
        }
    }

    var ascendingOrderTitle: String {
        self.viewModel.ascendingOrderTitle(for: self.sorting)
    }
}

#Preview {
    ZStack {
        Color.listBackground
            .ignoresSafeArea()
        ProjectListMenu(projectCount: 4, themes: [.all, .custom("DIY")])
            .tint(.white)
    }
}

enum StorageKey: String {
    case projectListSorting
    case projectListAscendingOrder
    case projectListShowTheme
    case projectListShowStatistics
    case projectListSelectedTheme
}

enum ProjectListSorting: String, Identifiable, CaseIterable {
    case updatedDate = "Modification Date"
    case createdDate = "Creation Date"
    case title = "Title"

    var id: ProjectListSorting { self }
}

enum ProjectListTheme: RawRepresentable, Hashable, Identifiable {
    case all
    case custom(String)

    var id: String { self.rawValue }

    var rawValue: String {
        switch self {
        case .all:
            return "All"
        case .custom(let value):
            return value
        }
    }

    init?(rawValue: String) {
        switch rawValue {
        case "All":
            self = .all
        default:
            self = .custom(rawValue)
        }
    }
}
