//
//  ProjectFormViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 25/10/2023.
//

import Foundation
import SwiftData

extension ProjectForm {
    @Observable
    final class ViewModel {
        // MARK: - Properties

        private let project: Project?
        private let store: ProjectStoreWritter
        private let formatter: ProjectFormatterProtocol
        private let validator: FormFieldValidatorProtocol

        var title: String = ""
        var theme: String = ""
        var isInvalidTitle: Bool = false
        var isInvalidTheme: Bool = false
        var error: Swift.Error? = nil
        @ObservationIgnored var didSaveProject: Bool = false

        // MARK: - Initialization

        init(
            project: Project?,
            store: ProjectStoreWritter = ProjectStore(),
            formatter: ProjectFormatterProtocol = ProjectFormatter(),
            validator: FormFieldValidatorProtocol = FormFieldValidator()
        ) {
            self.project = project
            self.store = store
            self.formatter = formatter
            self.validator = validator
        }

        // MARK: - Public

        func field(after currentField: FormTextField.Name?) -> FormTextField.Name? {
            switch currentField {
            case .title:
                return .theme
            case .theme, .link, .projectPicker, .none:
                return nil
            }
        }

        func update() {
            if let project {
                self.title = project.title
                self.theme = project.theme
            }
        }

        func save(in context: ModelContext) {
            do {
                try self.validator.validate(values: (.title, self.title), (.theme, self.theme))
                let values = self.formatter.values(title: self.title, theme: self.theme)
                self.save(values, in: context)
                self.didSaveProject = true
            } catch FormFieldValidator.Error.invalidFields(let fields) {
                self.isInvalidTitle = fields.contains(.title)
                self.isInvalidTheme = fields.contains(.theme)
            } catch {
                self.error = Error.save(error)
            }
        }
    }
}

// MARK: - Helpers

private extension ProjectForm.ViewModel {
    private func save(_ values: ProjectValues, in context: ModelContext) {
        if let project {
            self.store.update(project, with: values)
        } else {
            let project = self.formatter.project(from: values)
            self.store.create(project, in: context)
        }
    }
}

// MARK: - Error

extension ProjectForm.ViewModel {
    enum Error: LocalizedError {
        case save(Swift.Error)

        var errorDescription: String? {
            switch self {
            case .save: "Fail to save content"
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .save: "Check that the provided fields are valid and try again"
            }
        }
    }
}
