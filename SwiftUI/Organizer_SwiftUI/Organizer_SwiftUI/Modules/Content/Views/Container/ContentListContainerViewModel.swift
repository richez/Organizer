//
//  ContentListContainerViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 18/10/2023.
//

import Foundation

extension ContentListContainerView {
    struct ViewModel {
        func sortDescriptor(
            sorting: ContentListSorting,
            isAscendingOrder: Bool
        ) -> SortDescriptor<ProjectContent> {
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
            case .type:
                let order: SortOrder = isAscendingOrder ? .forward : .reverse
                return SortDescriptor(\.typeRawValue, order: order)
            }
        }

        func predicate(
            for project: Project,
            selectedTheme: String?,
            selectedType: ProjectContentType?
        ) -> Predicate<ProjectContent>? {
            let projectID = project.persistentModelID
            switch (selectedTheme, selectedType) {
            case (.none, .none):
                return #Predicate { $0.project?.persistentModelID == projectID }
            case (.none, .some(let selectedType)):
                let selectedTypeRawValue = selectedType.rawValue
                return #Predicate {
                    $0.project?.persistentModelID == projectID && $0.typeRawValue == selectedTypeRawValue
                }
            case (.some(let selectedTheme), .none):
                return #Predicate {
                    $0.project?.persistentModelID == projectID && $0.theme.contains(selectedTheme)
                }
            case (.some(let selectedTheme), .some(let selectedType)):
                let selectedTypeRawValue = selectedType.rawValue
                return #Predicate {
                    $0.project?.persistentModelID == projectID && $0.typeRawValue == selectedTypeRawValue && $0.theme.contains(selectedTheme)
                }
            }
        }
    }
}