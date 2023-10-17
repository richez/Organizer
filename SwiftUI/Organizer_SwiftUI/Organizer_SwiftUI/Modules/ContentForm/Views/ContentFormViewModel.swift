//
//  ContentFormViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 14/10/2023.
//

import Foundation
import SwiftData

extension ContentForm {
    struct ViewModel {
        var validator: FormFieldValidatorProtocol = FormFieldValidator()
        var urlMetadataProvider: URLMetadataProviderProtocol = URLMetadataProvider()

        func isValidURL(_ text: String) -> Bool {
            text.isValidURL()
        }

        func field(after currentField: FormTextField.Name?) -> FormTextField.Name? {
            switch currentField {
            case .link:
                return .title
            case .title:
                return .theme
            case .theme, .projectPicker, .none:
                return nil
            }
        }

        func title(of link: String) async throws -> String {
            return try await self.urlMetadataProvider.title(of: link)
        }

        func save(
            _ values: ContentForm.Values,
            for content: ProjectContent?,
            in project: Project,
            context: ModelContext
        ) throws {
            try self.validator.validate(values: (.link, values.link), (.title, values.title), (.theme, values.theme))

            if let content {
                self.updateContent(content, with: values)
            } else {
                self.addContent(with: values, to: project, in: context)
            }
        }
    }
}

// MARK: - Helpers

private extension ContentForm.ViewModel {
    func addContent(with values: ContentForm.Values, to project: Project, in context: ModelContext) {
        let content = ProjectContent(
            type: values.type,
            title: values.title.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: values.theme.trimmingCharacters(in: .whitespacesAndNewlines),
            link: values.link.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        content.project = project
        project.updatedDate = .now
        context.insert(content)
    }

    func updateContent(_ content: ProjectContent, with values: ContentForm.Values) {
        let type = values.type
        let link = values.link
        let title = values.title.trimmingCharacters(in: .whitespacesAndNewlines)
        let theme = values.theme.trimmingCharacters(in: .whitespacesAndNewlines)

        let hasChanges = type != content.type || link != content.link || title != content.title || theme != content.theme

        if hasChanges {
            content.typeRawValue = type.rawValue
            content.link = link
            content.title = title
            content.theme = theme
            content.updatedDate = .now
            content.project?.updatedDate = .now
        }
    }
}
