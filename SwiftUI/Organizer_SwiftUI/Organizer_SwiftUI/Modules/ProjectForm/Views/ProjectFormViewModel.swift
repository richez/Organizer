//
//  ProjectFormViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation
import SwiftData

extension ProjectForm {
    struct ViewModel {
        enum Error: Swift.Error {
            case invalidFields(Set<FormTextField.Name>)
        }

        var titleConfiguration: FormTextField.Configuration = .init(
            name: .title,
            sectionName: "Name",
            placeholder: "Your Project",
            submitLabel: .next,
            errorMessage: "This field cannot be empty"
        )

        var themeConfiguration: FormTextField.Configuration = .init(
            name: .theme,
            sectionName: "Themes",
            placeholder: "Sport, Construction, Work",
            submitLabel: .return,
            errorMessage: "This field is invalid"
        )

        func field(after currentField: FormTextField.Name?) -> FormTextField.Name? {
            switch currentField {
            case .title:
                return .theme
            case .theme, .none:
                return nil
            }
        }

        func commit(_ values: ProjectForm.Values, in context: ModelContext) throws {
            try self.validateFields(with: values)
            let project = Project(
                title: values.title.trimmingCharacters(in: .whitespacesAndNewlines),
                theme: values.theme.trimmingCharacters(in: .whitespacesAndNewlines)
            )
            context.insert(project)
        }
    }
}

// MARK: - Helpers

private extension ProjectForm.ViewModel {
    func validateFields(with values: ProjectForm.Values) throws {
        var invalidFields: Set<FormTextField.Name> = []
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
        case .title:
            !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        case .theme:
            true
        }
    }
}
