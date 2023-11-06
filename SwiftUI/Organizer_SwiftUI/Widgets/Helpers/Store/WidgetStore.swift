//
//  WidgetStore.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 26/10/2023.
//

import Foundation
import OSLog
import SwiftData

// TODO: Add AppGroup to macOS (main & widget)
struct WidgetStore {
    static var container: ModelContainer {
        get throws {
            try ModelContainer(for: Project.self, ProjectContent.self)
        }
    }

    var context: ModelContext?

    init() {
        do {
            self.context = try ModelContext(WidgetStore.container)
        } catch {
            Logger.swiftData.error("Fail to initialize model container: \(error)")
        }
    }
}

extension WidgetStore {
    func models<T: PersistentModel>(
        predicate: Predicate<T>? = nil,
        sortBy: [SortDescriptor<T>] = [],
        fetchLimit: Int? = nil,
        propertiesToFetch: [PartialKeyPath<T>] = [],
        relationshipKeyPathsForPrefetching: [PartialKeyPath<T>] = []
    ) throws -> [T] {
        guard let context else { throw Error.databaseUnreachable }

        var descriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
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
