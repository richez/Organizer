//
//  ProjectStoreProtocol.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 20/10/2023.
//

import Foundation
import SwiftData

protocol ProjectStoreDescriptor {
    func themeDescription(for selectedTheme: String?) -> String
    func sortDescriptor(sorting: ProjectListSorting, isAscendingOrder: Bool) -> SortDescriptor<Project>
    func predicate(selectedTeme: String?) -> Predicate<Project>?
}

protocol ProjectStoreReader {
    func project(for id: PersistentIdentifier, in context: ModelContext) -> Project?
    func themes(in context: ModelContext) -> [String]
    func themes(in projects: [Project]) -> [String]
}

protocol ProjectStoreWritter {
    func create(with values: ProjectForm.Values, in context: ModelContext)
    func update(_ project: Project, with values: ProjectForm.Values)
    func duplicate(_ project: Project, in context: ModelContext)
    func delete(_ project: Project, in context: ModelContext)
}

typealias ProjectStoreOperations = ProjectStoreReader & ProjectStoreWritter

typealias ProjectStoreProtocol = ProjectStoreDescriptor & ProjectStoreOperations
