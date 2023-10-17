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

        var linkConfiguration: FormTextField.Configuration = .init(
            name: .link,
            placeholder: "https://www.youtube.com",
            submitLabel: .next,
            errorMessage: "This field should start with http(s):// and be valid",
            autoCapitalization: .never,
            keyboardType: .URL,
            autocorrectionDisabled: true
        )

        var titleConfiguration: FormTextField.Configuration = .init(
            name: .title,
            placeholder: "My Content",
            submitLabel: .next,
            errorMessage: "This field cannot be empty",
            autoCapitalization: .words
        )

        var themeConfiguration: FormTextField.Configuration = .init(
            name: .theme,
            placeholder: "spots, tools, build",
            submitLabel: .return,
            errorMessage: "This field is invalid",
            autoCapitalization: .never
        )

        func isValidURL(_ text: String) -> Bool {
            text.isValidURL()
        }

        func field(after currentField: FormTextField.Name?) -> FormTextField.Name? {
            switch currentField {
            case .link:
                return .title
            case .title:
                return .theme
            case .theme, .none:
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
                self.createContent(with: values, in: project, context: context)
            }
        }
    }
}

// MARK: - Helpers

private extension ContentForm.ViewModel {
    func createContent(with values: ContentForm.Values, in project: Project, context: ModelContext) {
        let content = ProjectContent(
            type: values.type,
            title: values.title.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: values.theme.trimmingCharacters(in: .whitespacesAndNewlines),
            link: values.link.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        content.project = project
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
        }
    }
}
