//
//  WidgetStore.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 26/10/2023.
//

import Foundation
import SwiftData

// TODO: Add AppGroup to macOS (main & widget)
struct WidgetStore {
    var modelContainer: ModelContainer?
    var context: ModelContext?

    init() {
        do {
            self.modelContainer = try ModelContainer(for: Project.self, ProjectContent.self)
            self.context = ModelContext(self.modelContainer!)
            self.context!.autosaveEnabled = true
        } catch {
            print("Fail to initialize model container: \(error)")
        }
    }
}

extension WidgetStore {
    func projects(
        predicate: Predicate<Project>? = nil,
        sortBy: [SortDescriptor<Project>] = [],
        fetchLimit: Int? = nil,
        propertiesToFetch: [PartialKeyPath<Project>] = [],
        relationshipKeyPathsForPrefetching: [PartialKeyPath<Project>] = []
    ) throws -> [Project] {
        guard let context else { throw Error.databaseUnreachable }

        var descriptor = FetchDescriptor<Project>(predicate: predicate, sortBy: sortBy)
        descriptor.fetchLimit = fetchLimit
        descriptor.propertiesToFetch = propertiesToFetch
        descriptor.relationshipKeyPathsForPrefetching = relationshipKeyPathsForPrefetching
        return try context.fetch(descriptor)
    }
}

extension WidgetStore {
    enum Error: Swift.Error {
        case databaseUnreachable
    }
}
