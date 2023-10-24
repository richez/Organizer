//
//  DeeplinkManager.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 25/10/2023.
//

import Foundation
import SwiftData

// TODO: Error with title/message to display on MainView
struct DeeplinkManager {
    var projectStore: ProjectStoreReader = ProjectStore.shared
    var contentStore: ContentStoreReader = ContentStore.shared

    func target(for url: URL, context: ModelContext) throws -> Target {
        guard let deeplink = Deeplink(url: url) else {
            throw Error.invalidURL(url)
        }

        switch deeplink {
        case .projectForm:
            return .projectForm
        case .project(let id):
            let project = try self.project(with: id, context: context)
            return .project(project)
        case .content(let id, let projectID):
            let project = try self.project(with: projectID, context: context)
            let content = try self.content(with: id, in: project, context: context)
            return .content(content, in: project)
        }
    }
}

extension DeeplinkManager {
    enum Target {
        case projectForm
        case project(Project)
        case content(ProjectContent, in: Project)
    }

    enum Error: Swift.Error {
        case invalidURL(URL)
        case projectNotFound(String)
        case contentNotFound(String)
    }
}

// MARK: - Helpers

private extension DeeplinkManager {
    // MARK: Project

    func project(with identifier: String, context: ModelContext) throws -> Project {
        guard
            let uuid = UUID(uuidString: identifier),
            let project = self.projectStore.project(for: uuid, in: context)
        else {
            throw Error.projectNotFound(identifier)
        }

        return project
    }

    // MARK: Content

    func content(with identifier: String, in project: Project, context: ModelContext) throws -> ProjectContent {
        guard
            let uuid = UUID(uuidString: identifier),
            let content = self.contentStore.content(with: uuid, in: project, context: context)
        else {
            throw Error.contentNotFound(identifier)
        }

        return content
    }
}
