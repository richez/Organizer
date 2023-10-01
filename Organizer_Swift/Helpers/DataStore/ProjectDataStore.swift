//
//  ProjectDataStore.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation
import SwiftData

final class ProjectDataStore {
    static let shared: DataStoreProtocol = ProjectDataStore()

    // MARK: - Properties

    private let modelContainer: ModelContainer?
    private let context: ModelContext?

    // MARK: - Initialization

    init() {
        do {
            self.modelContainer = try ModelContainer(for: Project.self, ProjectContent.self)
            self.context = ModelContext(self.modelContainer!)
            self.context!.autosaveEnabled = true
        } catch {
            self.modelContainer = nil
            self.context = nil
            print("Fail to initialize model container: \(error)")
        }
    }
}

// MARK: - DataStoreProtocol

extension ProjectDataStore: DataStoreProtocol {
    // MARK: DataStoreReader

    func fetch<T: PersistentModel>(predicate: Predicate<T>?, sortBy: [SortDescriptor<T>]) throws -> [T] {
        guard let context else { throw DataStoreError.databaseUnreachable }

        let descriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
        return try context.fetch(descriptor)
    }

    func fetchCount<T: PersistentModel>(predicate: Predicate<T>?) throws -> Int {
        guard let context else { throw DataStoreError.databaseUnreachable }

        let descriptor = FetchDescriptor<T>(predicate: predicate, sortBy: [])
        return try context.fetchCount(descriptor)
    }

    func model<T: PersistentModel>(with identifier: PersistentIdentifier) throws -> T {
        guard let context else { throw DataStoreError.databaseUnreachable }
        guard let model = context.model(for: identifier) as? T else { throw DataStoreError.notFound(identifier) }

        return model
    }

    // MARK: DataStoreCreator

    func create(model: any PersistentModel) throws {
        guard let context else { throw DataStoreError.databaseUnreachable }

        context.insert(model)
        try context.save()
    }

    // MARK: DataStoreDeleter

    func delete(model: any PersistentModel) throws {
        guard let context else { throw DataStoreError.databaseUnreachable }

        context.delete(model)
        try context.save()
    }
}
