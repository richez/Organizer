//
//  ShareFormViewModel.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import Foundation
import SwiftData
import UniformTypeIdentifiers

final class ShareFormViewModel {
    private let dataStore: DataStoreReader & DataStoreCreator
    private var settings: AppGroupSettings

    init(dataStore: DataStoreReader & DataStoreCreator = ProjectDataStore.shared,
         settings: AppGroupSettings = .init()) {
        self.dataStore = dataStore
        self.settings = settings
    }
}

// MARK: - Public

extension ShareFormViewModel {
    var erroredViewConfiguration: ShareFormViewConfiguration {
        self.viewConfiguration(
            projectMenuItems: [],
            contentName: nil,
            contentLink: nil,
            errorMessage: "Could not retrieve data, please retry later"
        )
    }

    @MainActor
    func viewConfiguration(with extensionItem: NSExtensionItem?) async throws -> ShareFormViewConfiguration {
        let projects: [Project] = try self.dataStore.fetch(
            predicate: nil, sortBy: [SortDescriptor(\.lastUpdatedDate, order: .reverse)]
        )
        let projectMenuItems = projects.map { ShareFormMenuItem.custom(title: $0.title, id: $0.persistentModelID) }
        let contentName = extensionItem?.attributedTitle?.string ?? extensionItem?.attributedContentText?.string ?? ""
        let contentLink = try await self.url(in: extensionItem?.attachments)
        return self.viewConfiguration(
            projectMenuItems: projectMenuItems,
            contentName: contentName,
            contentLink: contentLink,
            errorMessage: nil
        )
    }

    func isFieldsValid(selectedProject: ProjectSelectedItem?,
                       type: String,
                       name: String,
                       theme: String,
                       link: String) -> Bool {
        let isValidSelectedProject = self.isSelectedProjectValid(selectedProject)
        let isValidType = ProjectContentType(rawValue: type) != nil
        let isValidName = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isValidTheme = true
        let isValidLink = !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return isValidSelectedProject && isValidType && isValidName && isValidTheme && isValidLink
    }

    func shouldHideProjectTextField(for selectedProject: ProjectSelectedItem?) -> Bool {
        switch selectedProject {
        case .new, .none:
            return false
        case .custom:
            return true
        }
    }

    var commitErrorMessage: String {
        "Could not save content, please retry later"
    }

    func commit(selectedProjectItem: ProjectSelectedItem?, type: String, name: String, theme: String, link: String) throws {
        switch selectedProjectItem {
        case .new(let title):
            let content = self.content(type: type, name: name, theme: theme, link: link)
            try self.createProject(title: title, content: content)
            self.settings.shareExtensionDidAddContent = true
        case .custom(let projectID):
            let content = self.content(type: type, name: name, theme: theme, link: link)
            try self.addContent(content, to: projectID)
            self.settings.shareExtensionDidAddContent = true
        case nil:
            throw ShareFormViewModelError.selectedProjectMissing
        }
    }
}

// MARK: - Helpers

private extension ShareFormViewModel {
    // MARK: View Configuration

    @MainActor
    func url(in attachments: [NSItemProvider]?) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            guard
                let urlAttachment = attachments?.first(where: { $0.hasItemConformingToTypeIdentifier(UTType.url.identifier) })
            else {
                return continuation.resume(throwing: ShareFormViewModelError.urlMissing)
            }

            urlAttachment.loadItem(forTypeIdentifier: UTType.url.identifier) { result, error in
                if let url = result as? URL {
                    continuation.resume(returning: url.absoluteString)
                } else {
                    continuation.resume(throwing: ShareFormViewModelError.urlLoading(error))
                }
            }
        }
    }

    func viewConfiguration(
        projectMenuItems: [ShareFormMenuItem],
        contentName: String?,
        contentLink: String?,
        errorMessage: String?) -> ShareFormViewConfiguration {
        .init(
            project: ShareFormMenu(
                text: "Project",
                placeholder: "My project",
                singleSelection: true,
                items: [.new(title: "New")] + projectMenuItems
            ),
            content: ContentFormViewConfiguration(
                saveButtonImageName: "checkmark",
                fields: ContentFormFieldsConfiguration(
                    type: ContentFormMenu(
                        text: "Type",
                        singleSelection: true,
                        items: ProjectContentType.allCases.map(\.rawValue),
                        selectedItem: ProjectContentType.article.rawValue
                    ),
                    name: ContentFormField(
                        text: "Name", placeholder: "My content", value: contentName
                    ),
                    theme: ContentFormField(
                        text: "Themes", placeholder: "Isolation, tennis, recherche", value: ""
                    ),
                    link: ContentFormField(
                        text: "Link", placeholder: "https://www.youtube.com", value: contentLink
                    )
                )
            ),
            errorMessage: errorMessage
        )
    }

    // MARK: Field Validation

    func isSelectedProjectValid(_ selectedProject: ProjectSelectedItem?) -> Bool {
        switch selectedProject {
        case .new(let projectName):
            return !projectName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        case .custom:
            return true
        case .none:
            return false
        }
    }

    // MARK: Project

    func content(type: String, name: String, theme: String, link: String) -> ProjectContent {
        .init(
            id: UUID(),
            type: ProjectContentType(rawValue: type) ?? .other,
            title: name.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: theme.trimmingCharacters(in: .whitespacesAndNewlines),
            link: link.trimmingCharacters(in: .whitespacesAndNewlines),
            creationDate: .now,
            lastUpdatedDate: .now
        )
    }

    func createProject(title: String, content: ProjectContent) throws {
        let project = Project(
            id: UUID(),
            title: title,
            theme: "",
            contents: [content],
            creationDate: .now,
            lastUpdatedDate: .now
        )

        try self.dataStore.create(model: project)
    }

    func addContent(_ content: ProjectContent, to projectID: PersistentIdentifier) throws {
        let project: Project = try self.dataStore.model(with: projectID)
        project.contents.append(content)
        project.lastUpdatedDate = .now
    }
}
