//
//  ContentView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

struct ContentView: View {
    var project: Project

    private let viewModel = ViewModel()

    @AppStorage(.contentListSorting)
    private var sorting: ContentListSorting = .updatedDate

    @AppStorage(.contentListAscendingOrder)
    private var isAscendingOrder: Bool = true

    @AppStorage(.contentListSelectedTheme)
    private var selectedTheme: ContentListTheme = .all

    @AppStorage(.contentListSelectedType)
    private var selectedType: ContentListType = .all

    init(project: Project) {
        self.project = project

        let defaults = UserDefaults(suiteName: project.suiteName)
        self._sorting = AppStorage(
            wrappedValue: .updatedDate, .contentListSorting, store: defaults
        )
        self._isAscendingOrder = AppStorage(
            wrappedValue: true, .contentListAscendingOrder, store: defaults
        )
        self._selectedTheme = AppStorage(
            wrappedValue: .all, .contentListSelectedTheme, store: defaults
        )
        self._selectedType = AppStorage(
            wrappedValue: .all, .contentListSelectedType, store: defaults
        )
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ContentListView(
                project: self.project,
                predicate: self.predicate,
                sort: self.sortDescriptor
            )

            FloatingButtonSheet(systemName: "plus") {
                
            }
        }
        .listStyle()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(self.project.title)
                    .foregroundStyle(.accent)
            }
        }
    }
}

private extension ContentView {
    var sortDescriptor: SortDescriptor<ProjectContent> {
        self.viewModel.sortDescriptor(
            sorting: self.sorting, isAscendingOrder: self.isAscendingOrder
        )
    }

    var predicate: Predicate<ProjectContent>? {
        self.viewModel.predicate(
            for: self.project,
            selectedTheme: self.selectedTheme,
            selectedType: self.selectedType
        )
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ContentView(project: PreviewDataGenerator.project)
        }
    }
}
