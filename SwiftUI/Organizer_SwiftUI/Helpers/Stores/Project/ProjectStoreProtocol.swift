//
//  ProjectStoreProtocol.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 20/10/2023.
//

import Foundation
import SwiftData

protocol ProjectStoreDescriptor {
    func sortDescriptor(sorting: ProjectListSorting, isAscendingOrder: Bool) -> SortDescriptor<Project>
    func predicate(selectedTeme: String?) -> Predicate<Project>?
}

protocol ProjectStoreReader {
    func project(with id: PersistentIdentifier, in context: ModelContext) -> Project?
    func project(with identifier: UUID, in context: ModelContext) -> Project?
    func projects(propertiesToFetch: [PartialKeyPath<Project>], in context: ModelContext) -> [Project]
}

protocol ProjectStoreWritter {
    func create(_ project: Project, in context: ModelContext)
    func create(_ project: Project, contents: [ProjectContent], in context: ModelContext)
    func update(_ project: Project, with values: ProjectValues)
    func duplicate(_ project: Project, in context: ModelContext)
    func delete(_ project: Project, in context: ModelContext)
}

typealias ProjectStoreOperations = ProjectStoreReader & ProjectStoreWritter

typealias ProjectStoreProtocol = ProjectStoreDescriptor & ProjectStoreOperations
