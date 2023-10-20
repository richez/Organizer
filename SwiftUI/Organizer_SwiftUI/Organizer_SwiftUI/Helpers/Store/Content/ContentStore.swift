//
//  ContentStore.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 20/10/2023.
//

import Foundation
import SwiftData

struct ContentStore {
    enum Error: Swift.Error {
        case invalidURL(String)
    }
}

// MARK: - ContentStoreDescriptor

extension ContentStore: ContentStoreDescriptor {
    func filtersDescription(for selectedTheme: String?, selectedType: ProjectContentType?) -> String {
        switch (selectedTheme, selectedType) {
        case (.none, .none): ""
        case (.none, .some(let selectedType)): "\(selectedType.rawValue)s"
        case (.some(let selectedTheme), .none): "#\(selectedTheme)"
        case (.some(let selectedTheme), .some(let selectedType)): "#\(selectedTheme) - \(selectedType.rawValue)s"
        }
    }
    
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
    func url(for content: ProjectContent) throws -> URL {
        guard content.link.isValidURL(), let url = URL(string: content.link) else {
            throw Error.invalidURL(content.link)
        }

        return url
    }
    
    func themes(in project: Project) -> [String] {
        return project.contents
            .flatMap(\.themes)
            .removingDuplicates()
            .sorted(using: .localizedStandard)
    }
}

// MARK: - ContentStoreWritter

extension ContentStore: ContentStoreWritter {
    func create(with values: ContentForm.Values, for project: Project, in context: ModelContext) {
        let content = ProjectContent(
            type: values.type,
            title: values.title.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: values.theme.trimmingCharacters(in: .whitespacesAndNewlines),
            link: values.link.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        content.project = project
        project.updatedDate = .now
        context.insert(content)
        project.contents.append(content)
    }
    
    func update(_ content: ProjectContent, with values: ContentForm.Values) {
        let type = values.type
        let link = values.link
        let title = values.title.trimmingCharacters(in: .whitespacesAndNewlines)
        let theme = values.theme.trimmingCharacters(in: .whitespacesAndNewlines)

        let hasChanges = type != content.type || link != content.link || title != content.title || theme != content.theme

        if hasChanges {
            content.typeRawValue = type.rawValue
            content.link = link
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
