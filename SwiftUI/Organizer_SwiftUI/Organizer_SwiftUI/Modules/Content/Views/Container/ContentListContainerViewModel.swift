//
//  ContentListContainerViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation
import OSLog

extension ContentListContainerView {
    struct ViewModel {
        // MARK: - Properties

        private let store: ContentStoreDescriptor

        // MARK: - Initialization

        init(store: ContentStoreDescriptor = ContentStore()) {
            self.store = store
        }

        // MARK: - Public

        func sortDescriptor(with sorting: ContentListSorting, isAscending: Bool) -> SortDescriptor<ProjectContent> {
            Logger.viewUpdates.info("""
          Update content list sorted by \(String(describing: sorting)) in \
          \(isAscending ? "ascending" : "descending") order
          """)

            return self.store.sortDescriptor(sorting: sorting, isAscendingOrder: isAscending)
        }

        func predicate(
            for project: Project,
            selectedTheme: String?,
            selectedType: ProjectContentType?
        ) -> Predicate<ProjectContent>? {
            Logger.viewUpdates.info("""
          Update content list with theme: \(String(describing: selectedTheme)) and \
          type \(String(describing: selectedType))
          """)

            return self.store.predicate(for: project, selectedTheme: selectedTheme, selectedType: selectedType)
        }
    }
}
