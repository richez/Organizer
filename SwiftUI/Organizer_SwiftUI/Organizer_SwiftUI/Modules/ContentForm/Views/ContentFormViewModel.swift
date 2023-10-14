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
        enum Error: Swift.Error {
            case invalidFields(Set<FormTextField.Name>)
        }

        var linkConfiguration: FormTextField.Configuration = .init(
            name: .link,
            placeholder: "https://www.youtube.com",
            submitLabel: .next,
            errorMessage: "This field should start with http(s):// and be valid"
        )

        var titleConfiguration: FormTextField.Configuration = .init(
            name: .title,
            placeholder: "Your Project",
            submitLabel: .next,
            errorMessage: "This field cannot be empty"
        )

        var themeConfiguration: FormTextField.Configuration = .init(
            name: .theme,
            placeholder: "Sport, Construction, Work",
            submitLabel: .return,
            errorMessage: "This field is invalid"
        )

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

        func save(
            _ values: ContentForm.Values,
            for content: ProjectContent?,
            in project: Project,
            context: ModelContext
        ) throws {
            try self.validateFields(with: values)

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
    // MARK: Validation

    func validateFields(with values: ContentForm.Values) throws {
        var invalidFields: Set<FormTextField.Name> = []
        self.validate(field: .link, text: values.link, with: &invalidFields)
        self.validate(field: .title, text: values.title, with: &invalidFields)
        self.validate(field: .theme, text: values.theme, with: &invalidFields)

        if !invalidFields.isEmpty {
            throw Error.invalidFields(invalidFields)
        }
    }

    func validate(field: FormTextField.Name, text: String, with invalidFields: inout Set<FormTextField.Name>) {
        if !self.isValidField(field, text: text) {
            invalidFields.insert(field)
        }
    }

    func isValidField(_ field: FormTextField.Name, text: String) -> Bool {
        switch field {
        case .link:
            text.isValidURL()
        case .title:
            !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        case .theme:
            true
        }
    }

    // MARK: Content

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
