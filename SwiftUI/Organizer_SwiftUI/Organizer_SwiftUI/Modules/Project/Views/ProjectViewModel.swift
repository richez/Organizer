//
//  ProjectViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation

extension ProjectView {
    struct ViewModel {
        func sortDescriptor(
            sorting: ProjectListSorting,
            isAscendingOrder: Bool
        ) -> SortDescriptor<Project> {
            switch sorting {
            case .updatedDate:
                let order: SortOrder = isAscendingOrder ? .reverse : .forward
                return SortDescriptor(\.updatedDate, order: order)
            case .createdDate:
                let order: SortOrder = isAscendingOrder ? .reverse : .forward
                return SortDescriptor(\.createdDate, order: order)
            case .title:
                let order: SortOrder = isAscendingOrder ? .forward : .reverse
                return SortDescriptor(\.title, comparator: .localizedStandard, order: order)
            }
        }

        func predicate(selectedTeme: ProjectListTheme) -> Predicate<Project>? {
            switch selectedTeme {
            case .all:
                return nil
            case .custom(let theme):
                return #Predicate {
                    $0.theme.contains(theme)
                }
            }
        }
    }
}
