//
//  ProjectContentCreatorViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import Foundation

struct ProjectContentCreatorViewModel {
    private let project: Project
    private let notificationCenter: NotificationCenter

    init(project: Project, notificationCenter: NotificationCenter = .default) {
        self.project = project
        self.notificationCenter = notificationCenter
    }
}

extension ProjectContentCreatorViewModel {
    var fieldsDescription: ProjectContentCreatorFieldsDescription {
        .init(
            type: ProjectContentCreatorMenu(text: "Type", items: ProjectContentType.allCases.map(\.rawValue)),
            name: ProjectContentCreatorField(text: "Name", placeholder: "My project"),
            theme: ProjectContentCreatorField(text: "Theme", placeholder: "Sport, Construction, Work"),
            link: ProjectContentCreatorField(text: "Link", placeholder: "https://www.youtube.com")
        )
    }

    func isFieldsValid(name: String, theme: String, link: String) -> Bool {
        let isValidName = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isValidTheme = true
        let isValidLink = !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return isValidName && isValidTheme && isValidLink
    }

    func createContent(type: String, name: String, theme: String, link: String) {
        let contentName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let contentTheme = theme.trimmingCharacters(in: .whitespacesAndNewlines)
        let contentLink = link.trimmingCharacters(in: .whitespacesAndNewlines)

        let projectContent = ProjectContent(
            id: UUID(),
            type: ProjectContentType(rawValue: type) ?? .other,
            title: contentName,
            theme: contentTheme,
            link: contentLink,
            creationDate: .now,
            lastUpdatedDate: .now
        )
        self.project.contents.append(projectContent)
        self.project.lastUpdatedDate = .now
        self.notificationCenter.post(name: .didCreateContent, object: nil)
        self.notificationCenter.post(name: .didUpdateProject, object: nil)
    }
}
