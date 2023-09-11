//
//  ProjectDataStore.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 08/09/2023.
//

import Foundation
import SwiftData

protocol ProjectDataStoreReader {
    func fetch() throws -> [Project]
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

    private let notificationCenter: NotificationCenter
    private let modelContainer: ModelContainer?
    private let context: ModelContext?

    // MARK: - Initialization

    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter

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

    func fetch() throws -> [Project] {
        guard let context else { throw ProjectDataStoreError.databaseUnreachable }

        let descriptor = FetchDescriptor<Project>(sortBy: [SortDescriptor(\.lastUpdatedDate, order: .reverse)])
        return try context.fetch(descriptor)
    }

    // MARK: ProjectDataStoreCreator

    func create(project: Project) throws {
        guard let context else { throw ProjectDataStoreError.databaseUnreachable }

        context.insert(project)
        try context.save()
        self.notificationCenter.post(name: .didCreateProject, object: nil)
    }

    // MARK: ProjectDataStoreDeleter

    func delete(projectID: UUID) throws {
        guard let context else { throw ProjectDataStoreError.databaseUnreachable }

        let predicate = #Predicate<Project> { trip in
            return trip.id == projectID
        }
        let descriptor = FetchDescriptor<Project>(predicate: predicate)
        guard let project = try context.fetch(descriptor).first else {
            throw ProjectDataStoreError.notFound(projectID)
        }

        context.delete(project)
        try context.save()
    }
}
