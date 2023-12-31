//
//  ContentStoreProtocol.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 20/10/2023.
//

import Foundation
import SwiftData

protocol ContentStoreDescriptor {
    func sortDescriptor(sorting: ContentListSorting, isAscendingOrder: Bool) -> SortDescriptor<ProjectContent>
    func predicate(for project: Project, selectedTheme: String?, selectedType: ProjectContentType?) -> Predicate<ProjectContent>?
}

protocol ContentStoreReader {
    func content(with identifier: UUID, in project: Project, context: ModelContext) -> ProjectContent?
}

protocol ContentStoreWritter {
    func create(_ content: ProjectContent, in project: Project, context: ModelContext)
    func update(_ content: ProjectContent, with values: ContentValues)
    func delete(_ content: ProjectContent, in context: ModelContext)
}

typealias ContentStoreOperations = ContentStoreReader & ContentStoreWritter

typealias ContentStoreProtocol = ContentStoreDescriptor & ContentStoreOperations
