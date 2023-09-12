//
//  ProjectContentViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import Foundation

struct ProjectContentViewModel {
    private let project: Project

    init(project: Project) {
        self.project = project
    }
}

// MARK: - Public

extension ProjectContentViewModel {
    var navigationBarTitle: String { self.project.title }
    var section: ProjectContentSection { .main }

    func fetchContentDescriptions() -> [ProjectContentDescription] {
        return self.project.contents
            .sorted(using: SortDescriptor(\.lastUpdatedDate, order: .reverse))
            .map { content in
                ProjectContentDescription(
                    id: content.id,
                    typeImageName: content.type.imageName,
                    title: content.title,
                    theme: content.theme.isEmpty ? "" : "#\(content.theme)"
                )
            }
    }
}

private extension ProjectContentType {
    var imageName: String {
        switch self {
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
}
