//
//  ContentListFetchDescriptor.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

struct ContentListFetchDescriptor {
    // MARK: - Properties

    private let settings: ContentListSettings

    // MARK: - Initialization

    init(settings: ContentListSettings) {
        self.settings = settings
    }
}

// MARK: - ContentListFetchDescriptorProtocol

extension ContentListFetchDescriptor: ContentListFetchDescriptorProtocol {
    var predicate: Predicate<ProjectContent>? {
        switch (self.settings.selectedTheme, self.settings.selectedType) {
        case (.all, .all):
            return nil
        case (.all, .custom(let selectedType)):
            return #Predicate<ProjectContent> { $0.type == selectedType }
        case (.custom(let selectedTheme), .all):
            return #Predicate<ProjectContent> { $0.theme.contains(selectedTheme) }
        case (.custom(let selectedTheme), .custom(let selectedType)):
            return #Predicate<ProjectContent> {
                $0.type == selectedType && $0.theme.contains(selectedTheme)
            }
        }
    }

    var sortDescriptor: [SortDescriptor<ProjectContent>] {
        switch self.settings.sorting {
        case .lastUpdated:
            let order: SortOrder = self.settings.ascendingOrder ? .reverse : .forward
            return [SortDescriptor(\.updatedDate, order: order)]
        case .creation:
            let order: SortOrder = self.settings.ascendingOrder ? .reverse : .forward
            return [SortDescriptor(\.createdDate, order: order)]
        case .title:
            let order: SortOrder = self.settings.ascendingOrder ? .forward : .reverse
            return [SortDescriptor(\.title, order: order)]
        case .type:
            let order: SortOrder = self.settings.ascendingOrder ? .forward : .reverse
            return [SortDescriptor(\.type.rawValue, order: order)]
        }
    }
}
