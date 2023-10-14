//
//  ContentViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation

extension ContentView {
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
            selectedTheme: ContentListTheme,
            selectedType: ContentListType
        ) -> Predicate<ProjectContent>? {
            let projectID = project.persistentModelID
            switch (selectedTheme, selectedType) {
            case (.all, .all):
                return #Predicate { $0.project?.persistentModelID == projectID }
            case (.all, .custom(let selectedType)):
                let selectedTypeRawValue = selectedType.rawValue
                return #Predicate {
                    $0.project?.persistentModelID == projectID && $0.typeRawValue == selectedTypeRawValue
                }
            case (.custom(let selectedTheme), .all):
                return #Predicate {
                    $0.project?.persistentModelID == projectID && $0.theme.contains(selectedTheme)
                }
            case (.custom(let selectedTheme), .custom(let selectedType)):
                let selectedTypeRawValue = selectedType.rawValue
                return #Predicate {
                    $0.project?.persistentModelID == projectID && $0.typeRawValue == selectedTypeRawValue && $0.theme.contains(selectedTheme)
                }
            }
        }

        func navbarSubtitle(
            selectedTheme: ContentListTheme,
            selectedType: ContentListType
        ) -> String {
            switch (selectedTheme, selectedType) {
            case (.all, .all):
                return ""
            case (.all, .custom(let selectedType)):
                return "\(selectedType.rawValue)s"
            case (.custom(let selectedTheme), .all):
                return "#\(selectedTheme)"
            case (.custom(let selectedTheme), .custom(let selectedType)):
                return "#\(selectedTheme) - \(selectedType.rawValue)s"
            }

        }
    }
}
