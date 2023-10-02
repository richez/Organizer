//
//  ProjectListFetchDescriptor.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 20/09/2023.
//

import Foundation

struct ProjectListFetchDescriptor {
    let settings: ProjectListSettings
}

// MARK: - ProjectListFetchDescriptorProtocol

extension ProjectListFetchDescriptor: ProjectListFetchDescriptorProtocol {
    var predicate: Predicate<Project>? {
        switch self.settings.selectedTheme {
        case .all:
            return nil
        case .custom(let selectedTheme):
            return #Predicate<Project> { $0.theme.contains(selectedTheme) }
        }
    }

    var sortDescriptor: [SortDescriptor<Project>] {
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
        }
    }
}
