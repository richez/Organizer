//
//  ProjectContentListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import Foundation

struct ProjectContentListViewModel {
    private let project: Project
    private let notificationCenter: NotificationCenter

    init(project: Project, notificationCenter: NotificationCenter = .default) {
        self.project = project
        self.notificationCenter = notificationCenter
    }
}

// MARK: - Public

extension ProjectContentListViewModel {
    var navigationBarTitle: String { self.project.title }
    var section: ProjectContentSection { .main }

    func fetchContentDescriptions() -> [ProjectContentDescription] {
        return self.project.contents
            .sorted(using: SortDescriptor(\.lastUpdatedDate, order: .reverse))
            .map { content in
                ProjectContentDescription(
                    id: content.id,
                    typeImageName: self.imageName(for: content.type),
                    title: content.title,
                    theme: self.theme(for: content)
                )
            }
    }

    func deleteContent(with id: UUID) throws {
        guard let index = self.project.contents.firstIndex(where: { $0.id == id }) else {
            throw ProjectContentListViewModelError.delete(id)
        }

        self.project.contents.remove(at: index)
        self.project.lastUpdatedDate = .now
        self.notificationCenter.post(name: .didUpdateProjectContent, object: nil)
    }
}

// MARK: - Helpers

private extension ProjectContentListViewModel {
    // MARK: Project Content

    func imageName(for contentType: ProjectContentType) -> String {
        switch contentType {
        case .article:
            return "newspaper"
        case .note:
            return "note"
        case .video:
            return "video"
        case .other:
            return "questionmark.square"
        }
    }

    func theme(for content: ProjectContent) -> String {
        return content.themes.map { "#\($0)" }.joined(separator: " ")
    }
}
