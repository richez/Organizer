//
//  ContentStoreProtocol.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 20/10/2023.
//

import Foundation
import SwiftData

protocol ContentStoreDescriptor {
    func filtersDescription(for selectedTheme: String?, selectedType: ProjectContentType?) -> String
    func sortDescriptor(sorting: ContentListSorting, isAscendingOrder: Bool) -> SortDescriptor<ProjectContent>
    func predicate(for project: Project, selectedTheme: String?, selectedType: ProjectContentType?) -> Predicate<ProjectContent>?
}

protocol ContentStoreReader {
    func url(for content: ProjectContent) throws -> URL
    func themes(in project: Project) -> [String]
}

protocol ContentStoreWritter {
    func create(with values: ContentValues, for project: Project, in context: ModelContext)
    func update(_ content: ProjectContent, with values: ContentValues)
    func delete(_ content: ProjectContent, in context: ModelContext)
}

typealias ContentStoreOperations = ContentStoreReader & ContentStoreWritter

typealias ContentStoreProtocol = ContentStoreDescriptor & ContentStoreOperations
