//
//  FormFieldValidator.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 17/10/2023.
//

import Foundation

protocol FormFieldValidatorProtocol {
    func validate(values: (FormTextField.Name, String)...) throws
}

struct FormFieldValidator {
    enum Error: Swift.Error {
        case invalidFields(Set<FormTextField.Name>)
    }
}

// MARK: - FormFieldValidatorProtocol

extension FormFieldValidator: FormFieldValidatorProtocol {
    func validate(values: (FormTextField.Name, String)...) throws {
        var invalidFields: Set<FormTextField.Name> = []
        values.forEach { value in
            self.validate(field: value.0, text: value.1, with: &invalidFields)
        }

        if !invalidFields.isEmpty {
            throw Error.invalidFields(invalidFields)
        }
    }
}

// MARK: - Helpers

private extension FormFieldValidator {
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
}
