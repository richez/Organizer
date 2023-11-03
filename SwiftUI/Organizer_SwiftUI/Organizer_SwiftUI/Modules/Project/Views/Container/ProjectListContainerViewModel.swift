//
//  ProjectListContainerViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation

extension ProjectListContainerView {
    struct ViewModel {
        // MARK: - Properties

        private let store: ProjectStoreDescriptor

        // MARK: - Initialization

        init(store: ProjectStoreDescriptor = ProjectStore()) {
            self.store = store
        }

        // MARK: - Public

        func sortDescriptor(with sorting: ProjectListSorting, isAscending: Bool) -> SortDescriptor<Project> {
            self.store.sortDescriptor(sorting: sorting, isAscendingOrder: isAscending)
        }

        func predicate(with selectedTheme: String?) -> Predicate<Project>? {
            self.store.predicate(selectedTeme: selectedTheme)
        }
    }
}
