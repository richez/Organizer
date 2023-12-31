//
//  ContentListContainerView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ContentListContainerView: View {
    var project: Project

    private let viewModel = ViewModel()

    @AppStorage(.contentListSorting)
    private var sorting: ContentListSorting = .updatedDate

    @AppStorage(.contentListAscendingOrder)
    private var isAscendingOrder: Bool = true

    @AppStorage(.contentListSelectedTheme)
    private var selectedTheme: String? = nil

    @AppStorage(.contentListSelectedType)
    private var selectedType: ProjectContentType?

    init(project: Project) {
        self.project = project

        let defaults = UserDefaults(suiteName: project.identifier.uuidString)
        self._sorting.update(with: defaults, key: .contentListSorting)
        self._isAscendingOrder.update(with: defaults, key: .contentListAscendingOrder)
        self._selectedTheme.update(with: defaults, key: .contentListSelectedTheme)
        self._selectedType.update(with: defaults, key: .contentListSelectedType)
    }

    var body: some View {
        ContentListView(
            project: self.project,
            predicate: self.predicate,
            sort: self.sortDescriptor
        )
        .listStyle()
    }
}

private extension ContentListContainerView {
    var sortDescriptor: SortDescriptor<ProjectContent> {
        self.viewModel.sortDescriptor(with: self.sorting, isAscending: self.isAscendingOrder)
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
            ContentListContainerView(project: PreviewDataGenerator.project)
                .listStyle()
        }
    }
}
