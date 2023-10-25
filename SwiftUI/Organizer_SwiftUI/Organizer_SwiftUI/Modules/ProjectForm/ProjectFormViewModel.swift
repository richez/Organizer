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
        private let project: Project?
        private let store: ProjectStoreWritter
        private let validator: FormFieldValidatorProtocol

        var title: String = ""
        var theme: String = ""
        var isInvalidTitle: Bool = false
        var isInvalidTheme: Bool = false
        var hasUnknownError: Bool = false
        @ObservationIgnored var didSaveProject: Bool = false

        init(
            project: Project?,
            store: ProjectStoreWritter = ProjectStore.shared,
            validator: FormFieldValidatorProtocol = FormFieldValidator()
        ) {
            self.project = project
            self.store = store
            self.validator = validator
        }

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
                let values = ProjectValues(title: self.title, theme: self.theme)
                self.save(values, in: context)
                self.didSaveProject = true
            } catch FormFieldValidator.Error.invalidFields(let fields) {
                self.isInvalidTitle = fields.contains(.title)
                self.isInvalidTheme = fields.contains(.theme)
            } catch {
                self.hasUnknownError = true
            }
        }
    }
}

private extension ProjectForm.ViewModel {
    private func save(_ values: ProjectValues, in context: ModelContext) {
        if let project {
            self.store.update(project, with: values)
        } else {
            self.store.create(with: values, in: context)
        }
    }
}
