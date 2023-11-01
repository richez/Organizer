//
//  ContentListContainerViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation

extension ContentListContainerView {
    struct ViewModel {
        // MARK: - Properties

        private let store: ContentStoreDescriptor

        // MARK: - Initialization

        init(store: ContentStoreDescriptor = ContentStore.shared) {
            self.store = store
        }

        // MARK: - Public

        func sortDescriptor(with sorting: ContentListSorting, isAscending: Bool) -> SortDescriptor<ProjectContent> {
            self.store.sortDescriptor(sorting: sorting, isAscendingOrder: isAscending)
        }

        func predicate(
            for project: Project,
            selectedTheme: String?,
            selectedType: ProjectContentType?
        ) -> Predicate<ProjectContent>? {
            self.store.predicate(for: project, selectedTheme: selectedTheme, selectedType: selectedType)
        }
    }
}
