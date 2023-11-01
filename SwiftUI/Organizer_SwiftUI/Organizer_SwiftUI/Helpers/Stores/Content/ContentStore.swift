//
//  ContentStore.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 20/10/2023.
//

import Foundation
import SwiftData

struct ContentStore {
    // MARK: - Properties

    static let shared: ContentStoreProtocol = ContentStore()

    // MARK: - Initialization

    private init() {}

    // MARK: - Error

    enum Error: Swift.Error {
        case invalidURL(String)
    }
}

// MARK: - ContentStoreDescriptor

extension ContentStore: ContentStoreDescriptor {    
    func sortDescriptor(sorting: ContentListSorting, isAscendingOrder: Bool) -> SortDescriptor<ProjectContent> {
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
    
    func predicate(for project: Project, selectedTheme: String?, selectedType: ProjectContentType?) -> Predicate<ProjectContent>? {
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

// MARK: - ContentStoreReader

extension ContentStore: ContentStoreReader {
    func content(with identifier: UUID, in project: Project, context: ModelContext) -> ProjectContent? {
        let projectID = project.persistentModelID
        var descriptor = FetchDescriptor<ProjectContent>(predicate: #Predicate {
            $0.project?.persistentModelID == projectID && $0.identifier == identifier
        })
        descriptor.fetchLimit = 1
        let contents = (try? context.fetch(descriptor)) ?? []
        return contents.first
    }
}

// MARK: - ContentStoreWritter

extension ContentStore: ContentStoreWritter {
    func create(_ content: ProjectContent, in project: Project, context: ModelContext) {
        content.project = project
        project.updatedDate = .now
        context.insert(content)
        project.contents.append(content)
    }

    func update(_ content: ProjectContent, with values: ContentValues) {
        let type = values.type
        let url = values.url
        let title = values.title
        let theme = values.theme

        let hasChanges = type != content.type || url != content.url || title != content.title || theme != content.theme

        if hasChanges {
            content.typeRawValue = type.rawValue
            content.url = url
            content.title = title
            content.theme = theme
            content.updatedDate = .now
            content.project?.updatedDate = .now
        }
    }
    
    func delete(_ content: ProjectContent, in context: ModelContext) {
        context.delete(content)
    }
}
