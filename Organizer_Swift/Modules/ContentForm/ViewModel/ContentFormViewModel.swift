//
//  ContentFormViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import Foundation

struct ContentFormViewModel {
    // MARK: - Properties

    private let mode: ContentFormMode
    private let project: Project
    private let notificationCenter: NotificationCenter

    // MARK: - Initialization

    init(mode: ContentFormMode,
         project: Project,
         notificationCenter: NotificationCenter = .default) {
        self.mode = mode
        self.project = project
        self.notificationCenter = notificationCenter
    }
}

// MARK: - Public

extension ContentFormViewModel {
    var viewConfiguration: ContentFormViewConfiguration {
        .init(
            saveButtonImageName: "checkmark",
            fields: ContentFormFieldsConfiguration(
                type: ContentFormMenu(
                    text: "Type",
                    singleSelection: true,
                    items: ProjectContentType.allCases.map(\.rawValue),
                    selectedItem: self.typeMenuSelectedValue
                ),
                name: ContentFormField(
                    text: "Name", placeholder: "My content", value: self.nameFieldValue, tag: 1
                ),
                theme: ContentFormField(
                    text: "Themes", placeholder: "Isolation, tennis, recherche", value: self.themeFieldValue, tag: 2
                ),
                link: ContentFormField(
                    text: "Link", placeholder: "https://www.youtube.com", value: self.linkFieldValue, tag: 3
                )
            )
        )
    }

    func isFieldsValid(type: String, name: String, theme: String, link: String) -> Bool {
        switch self.mode {
        case .create:
            let isValidType = ProjectContentType(rawValue: type) != nil
            let isValidName = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            let isValidTheme = true
            let isValidLink = !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return isValidType && isValidName && isValidTheme && isValidLink
        case .update(let content):
            let isValidType = ProjectContentType(rawValue: type) != content.type
            let isValidName = name.trimmingCharacters(in: .whitespacesAndNewlines) != content.title
            let isValidTheme = theme.trimmingCharacters(in: .whitespacesAndNewlines) != content.theme
            let isValidLink = link.trimmingCharacters(in: .whitespacesAndNewlines) != content.link
            return isValidType || isValidName || isValidTheme || isValidLink
        }

    }

    func commit(type: String, name: String, theme: String, link: String) {
        switch self.mode {
        case .create:
            self.createContent(type: type, name: name, theme: theme, link: link)
        case .update(let content):
            self.updateContent(content, type: type, name: name, theme: theme, link: link)
        }
    }
}

// MARK: - Helpers

private extension ContentFormViewModel {
    // MARK: Fields

    var typeMenuSelectedValue: String {
        switch self.mode {
        case .create:
            return ProjectContentType.article.rawValue
        case .update(let content):
            return content.type.rawValue
        }
    }

    var nameFieldValue: String? {
        switch self.mode {
        case .create:
            return nil
        case .update(let content):
            return content.title
        }
    }

    var themeFieldValue: String? {
        switch self.mode {
        case .create:
            return nil
        case .update(let content):
            return content.theme
        }
    }

    var linkFieldValue: String? {
        switch self.mode {
        case .create:
            return nil
        case .update(let content):
            return content.link
        }
    }

    // MARK: Content

    func createContent(type: String, name: String, theme: String, link: String) {
        let projectContent = ProjectContent(
            id: UUID(),
            type: ProjectContentType(rawValue: type) ?? .other,
            title: name.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: theme.trimmingCharacters(in: .whitespacesAndNewlines),
            link: link.trimmingCharacters(in: .whitespacesAndNewlines),
            creationDate: .now,
            lastUpdatedDate: .now
        )
        self.project.contents.append(projectContent)
        self.project.lastUpdatedDate = .now
        self.notificationCenter.post(name: .didCreateContent, object: nil)
        self.notificationCenter.post(name: .didUpdateProjectContent, object: nil)
    }

    func updateContent(_ content: ProjectContent, type: String, name: String, theme: String, link: String) {
        content.type = ProjectContentType(rawValue: type) ?? .other
        content.title = name.trimmingCharacters(in: .whitespacesAndNewlines)
        content.theme = theme.trimmingCharacters(in: .whitespacesAndNewlines)
        content.link = link.trimmingCharacters(in: .whitespacesAndNewlines)
        content.lastUpdatedDate = .now

        self.project.lastUpdatedDate = .now
        self.notificationCenter.post(name: .didUpdateContent, object: nil)
        self.notificationCenter.post(name: .didUpdateProjectContent, object: nil)
    }
}

