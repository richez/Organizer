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
    private let urlMetadataProvider: URLMetadataProviderProtocol
    private let notificationCenter: NotificationCenter

    // MARK: - Initialization

    init(mode: ContentFormMode,
         project: Project,
         urlMetadataProvider: URLMetadataProviderProtocol,
         notificationCenter: NotificationCenter = .default) {
        self.mode = mode
        self.project = project
        self.urlMetadataProvider = urlMetadataProvider
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
                link: ContentFormField(
                    text: "Link", placeholder: "https://www.youtube.com", value: self.linkFieldValue, tag: 1
                ),
                linkError: ContentFormError(
                    text: "should start with http(s):// and be valid",
                    isHidden: self.linkFieldValue.isNil || self.linkFieldValue?.isValidURL() == true
                ),
                name: ContentFormField(
                    text: "Name", placeholder: "My content", value: self.nameFieldValue, tag: 2
                ),
                nameGetter: ContentFormButton(text: "Get Link Name", isEnabled: self.linkFieldValue?.isValidURL() == true),
                theme: ContentFormField(
                    text: "Themes", placeholder: "Isolation, tennis, recherche", value: self.themeFieldValue, tag: 3
                )
            )
        )
    }

    func isFieldsValid(type: String, link: String, name: String, theme: String) -> Bool {
        let type = ProjectContentType(rawValue: type)
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let theme = theme.trimmingCharacters(in: .whitespacesAndNewlines)

        switch self.mode {
        case .create:
            let isValidType = type != nil
            let isValidLink = link.isValidURL()
            let isValidName = !name.isEmpty
            let isValidTheme = true
            return isValidType && isValidLink && isValidName && isValidTheme
        case .update(let content):
            let isValidType = type != content.type
            let isValidLink = link != content.link && link.isValidURL()
            let isValidName = name != content.title && !name.isEmpty
            let isValidTheme = theme != content.theme
            return isValidType || isValidLink || isValidName || isValidTheme
        }
    }

    func isValidLink(_ link: String) -> Bool {
        return link.isValidURL()
    }

    func linkTitle(for link: String) async throws -> String {
        do {
            return try await self.urlMetadataProvider.title(for: link)
        } catch {
            throw ContentFormViewModelError.urlMetadataProvider(link, error)
        }
    }

    func commit(type: String, link: String, name: String, theme: String) {
        switch self.mode {
        case .create:
            self.createContent(type: type, link: link, name: name, theme: theme)
        case .update(let content):
            self.updateContent(content, type: type, link: link, name: name, theme: theme)
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

    func createContent(type: String, link: String, name: String, theme: String) {
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

    func updateContent(_ content: ProjectContent, type: String, link: String, name: String, theme: String) {
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
