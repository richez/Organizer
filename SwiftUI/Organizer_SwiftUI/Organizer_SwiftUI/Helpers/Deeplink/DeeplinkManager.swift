//
//  DeeplinkManager.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 25/10/2023.
//

import Foundation
import SwiftData

struct DeeplinkManager {
    var projectStore: ProjectStoreReader = ProjectStore.shared
    var contentStore: ContentStoreReader = ContentStore.shared

    enum Target {
        case projectForm
        case project(Project)
        case content(ProjectContent, in: Project)
    }

    func target(for url: URL, context: ModelContext) throws -> Target {
        guard let deeplink = Deeplink(url: url) else {
            throw Error.unsupportedURL(url)
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

// MARK: - Helpers

private extension DeeplinkManager {
    // MARK: Project

    func project(with identifier: String, context: ModelContext) throws -> Project {
        guard
            let uuid = UUID(uuidString: identifier),
            let project = self.projectStore.project(with: uuid, in: context)
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
            throw Error.contentNotFound(identifier, in: project)
        }

        return content
    }
}

extension DeeplinkManager {
    enum Error: LocalizedError {
        case unsupportedURL(URL)
        case projectNotFound(String)
        case contentNotFound(String, in: Project)

        var errorDescription: String? {
            switch self {
            case .unsupportedURL: "Could not open url"
            case .projectNotFound: "Could not find project"
            case .contentNotFound: "Could not find content"
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .unsupportedURL(let url): "Check that the provided url is valid and try again: \(url.absoluteString)"
            case .projectNotFound: "Verify that the project exists and try again"
            case .contentNotFound(_, let project): "Verify that the content exists in project '\(project.title)' and try again"
            }
        }
    }
}
