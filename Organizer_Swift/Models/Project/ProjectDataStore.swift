//
//  ProjectDataStore.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 08/09/2023.
//

import Foundation
import SwiftData

protocol ProjectDataStoreReader {
    func fetch(predicate: Predicate<Project>?, sortBy: [SortDescriptor<Project>]) throws -> [Project]
    func fetchCount(predicate: Predicate<Project>?, sortBy: [SortDescriptor<Project>]) throws -> Int
    func project(with projectID: UUID) throws -> Project
}

protocol ProjectDataStoreCreator {
    func create(project: Project) throws
}

protocol ProjectDataStoreDeleter {
    func delete(projectID: UUID) throws
}

protocol ProjectDataStoreProtocol: ProjectDataStoreReader & ProjectDataStoreCreator & ProjectDataStoreDeleter {}

enum ProjectDataStoreError: Error {
    case databaseUnreachable
    case notFound(UUID)
}

final class ProjectDataStore {
    static let shared: ProjectDataStoreProtocol = ProjectDataStore()

    // MARK: - Properties

    private let modelContainer: ModelContainer?
    private let context: ModelContext?

    // MARK: - Initialization

    init() {
        do {
            self.modelContainer = try ModelContainer(for: Project.self)
            self.context = ModelContext(self.modelContainer!)
            self.context!.autosaveEnabled = true
        } catch {
            self.modelContainer = nil
            self.context = nil
            print("Fail to initialize model container: \(error)")
        }
    }
}

// MARK: - ProjectDataStoreProtocol

extension ProjectDataStore: ProjectDataStoreProtocol {
    // MARK: ProjectDataStoreReader

    func fetch(predicate: Predicate<Project>?, sortBy: [SortDescriptor<Project>]) throws -> [Project] {
        guard let context else { throw ProjectDataStoreError.databaseUnreachable }

        let descriptor = FetchDescriptor<Project>(predicate: predicate, sortBy: sortBy)
        return try context.fetch(descriptor)
    }

    func fetchCount(predicate: Predicate<Project>?, sortBy: [SortDescriptor<Project>]) throws -> Int {
        guard let context else { throw ProjectDataStoreError.databaseUnreachable }

        let descriptor = FetchDescriptor<Project>(predicate: predicate, sortBy: sortBy)
        return try context.fetchCount(descriptor)
    }

    func project(with projectID: UUID) throws -> Project {
        guard let context else { throw ProjectDataStoreError.databaseUnreachable }

        let predicate = #Predicate<Project> { project in
            return project.id == projectID
        }
        var descriptor = FetchDescriptor<Project>(predicate: predicate)
        descriptor.fetchLimit = 1
        guard let project = try context.fetch(descriptor).first else {
            throw ProjectDataStoreError.notFound(projectID)
        }

        return project
    }

    // MARK: ProjectDataStoreCreator

    func create(project: Project) throws {
        guard let context else { throw ProjectDataStoreError.databaseUnreachable }

        context.insert(project)
        try context.save()
    }

    // MARK: ProjectDataStoreDeleter

    func delete(projectID: UUID) throws {
        guard let context else { throw ProjectDataStoreError.databaseUnreachable }

        let project = try self.project(with: projectID)
        context.delete(project)
        try context.save()
    }
}
