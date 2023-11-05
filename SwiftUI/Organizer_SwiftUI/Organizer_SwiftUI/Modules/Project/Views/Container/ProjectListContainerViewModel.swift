//
//  ProjectListContainerViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation
import OSLog

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
            Logger.viewUpdates.info("""
          Update project list sorted by \(String(describing: sorting)) in \
          \(isAscending ? "ascending" : "descending") order
          """)

            return self.store.sortDescriptor(sorting: sorting, isAscendingOrder: isAscending)
        }

        func predicate(with selectedTheme: String?) -> Predicate<Project>? {
            Logger.viewUpdates.info("Update project list with theme: \(String(describing: selectedTheme))")

            return self.store.predicate(selectedTeme: selectedTheme)
        }
    }
}
