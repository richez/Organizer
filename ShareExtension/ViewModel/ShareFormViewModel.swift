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
    var emptyViewConfiguration: ShareFormViewConfiguration {
        self.viewConfiguration(
            projectMenuItems: [],
            contentLink: nil,
            contentName: nil
        )
    }

    var viewConfigurationErrorAlert: ShareFormErrorAlert {
        .init(title: "Fail to load data", cancelTitle: "Cancel", retryTitle: "Retry")
    }

    @MainActor
    func viewConfiguration(with extensionItem: NSExtensionItem?) async throws -> ShareFormViewConfiguration {
        let projects: [Project] = try self.dataStore.fetch(
            predicate: nil, sortBy: [SortDescriptor(\.lastUpdatedDate, order: .reverse)]
        )
        let projectMenuItems = projects.map { ShareFormMenuItem.custom(title: $0.title, id: $0.persistentModelID) }
        let contentLink = try await self.url(in: extensionItem?.attachments)
        let contentName = extensionItem?.attributedTitle?.string ?? extensionItem?.attributedContentText?.string ?? ""
        return self.viewConfiguration(
            projectMenuItems: projectMenuItems,
            contentLink: contentLink,
            contentName: contentName
        )
    }

    func isFieldsValid(for values: ShareFormFieldValues) -> Bool {
        let isValidSelectedProject = self.isSelectedProjectValid(values.selectedProject)
        let isValidType = ProjectContentType(rawValue: values.content.type) != nil
        let isValidLink = values.content.link.isValidURL()
        let isValidName = !values.content.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isValidTheme = true
        return isValidSelectedProject && isValidType && isValidLink && isValidName && isValidTheme
    }

    func isValidLink(_ link: String) -> Bool {
        return link.isValidURL()
    }

    func shouldHideProjectTextField(for selectedProject: ProjectSelectedItem?) -> Bool {
        switch selectedProject {
        case .new, .none:
            return false
        case .custom:
            return true
        }
    }

    var commitErrorAlert: ShareFormErrorAlert {
        .init(title: "Fail to create content", cancelTitle: "Cancel", retryTitle: "Retry")
    }

    func commit(values: ShareFormFieldValues) throws {
        switch values.selectedProject {
        case .new(let title):
            let content = self.content(with: values.content)
            try self.createProject(title: title, content: content)
            self.settings.shareExtensionDidAddContent = true
        case .custom(let projectID):
            let content = self.content(with: values.content)
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
        contentLink: String?,
        contentName: String?) -> ShareFormViewConfiguration {
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
                    link: ContentFormField(
                        text: "Link", placeholder: "https://www.youtube.com", value: contentLink, tag: 1
                    ),
                    linkError: ContentFormError(
                        text: "should start with http(s):// and be valid",
                        isHidden: contentLink.isNil || contentLink?.isValidURL() == true
                    ),
                    name: ContentFormField(
                        text: "Name", placeholder: "My content", value: contentName, tag: 2
                    ),
                    nameGetter: ContentFormButton(text: nil, isEnabled: false),
                    theme: ContentFormField(
                        text: "Themes", placeholder: "Isolation, tennis, recherche", value: "", tag: 3
                    )
                )
            )
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

    func content(with values: ContentFormFieldValues) -> ProjectContent {
        .init(
            id: UUID(),
            type: ProjectContentType(rawValue: values.type) ?? .other,
            title: values.name.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: values.theme.trimmingCharacters(in: .whitespacesAndNewlines),
            link: values.link.trimmingCharacters(in: .whitespacesAndNewlines),
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
