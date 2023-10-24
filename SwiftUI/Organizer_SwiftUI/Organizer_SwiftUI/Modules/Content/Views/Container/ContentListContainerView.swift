//
//  ContentListContainerView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ContentListContainerView: View {
    var project: Project
    @Binding var selected: ProjectContent?

    private let store: ContentStoreDescriptor = ContentStore.shared

    @AppStorage(.contentListSorting)
    private var sorting: ContentListSorting = .updatedDate

    @AppStorage(.contentListAscendingOrder)
    private var isAscendingOrder: Bool = true

    @AppStorage(.contentListSelectedTheme)
    private var selectedTheme: String? = nil

    @AppStorage(.contentListSelectedType)
    private var selectedType: ProjectContentType?

    init(project: Project, selected: Binding<ProjectContent?>) {
        self.project = project
        self._selected = selected

        let defaults = UserDefaults(suiteName: project.identifier.uuidString)
        self._sorting.update(with: defaults, key: .contentListSorting)
        self._isAscendingOrder.update(with: defaults, key: .contentListAscendingOrder)
        self._selectedTheme.update(with: defaults, key: .contentListSelectedTheme)
        self._selectedType.update(with: defaults, key: .contentListSelectedType)
    }

    var body: some View {
        ContentListView(
            project: self.project,
            selected: self.$selected,
            predicate: self.predicate,
            sort: self.sortDescriptor
        )
        .listStyle()
        .focusedSceneValue(\.selectedContent, self.$selected)
    }
}

private extension ContentListContainerView {
    var sortDescriptor: SortDescriptor<ProjectContent> {
        self.store.sortDescriptor(
            sorting: self.sorting,
            isAscendingOrder: self.isAscendingOrder
        )
    }

    var predicate: Predicate<ProjectContent>? {
        self.store.predicate(
            for: self.project,
            selectedTheme: self.selectedTheme,
            selectedType: self.selectedType
        )
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ContentListContainerView(project: PreviewDataGenerator.project, selected: .constant(nil))
                .listStyle()
        }
    }
}
