//
//  ProjectListFetchDescriptor.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 20/09/2023.
//

import Foundation

protocol ProjectListFetchDescriptorProtocol {
    var predicate: Predicate<Project>? { get }
    var sortDescriptor: [SortDescriptor<Project>] { get }
}

struct ProjectListFetchDescriptor {
    // MARK: - Properties

    private let settings: ProjectListSettings

    // MARK: - Initialization

    init(settings: ProjectListSettings) {
        self.settings = settings
    }
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
            return [SortDescriptor(\.lastUpdatedDate, order: order)]
        case .creation:
            let order: SortOrder = self.settings.ascendingOrder ? .reverse : .forward
            return [SortDescriptor(\.creationDate, order: order)]
        case .title:
            let order: SortOrder = self.settings.ascendingOrder ? .forward : .reverse
            return [SortDescriptor(\.title, order: order)]
        }
    }
}