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
        var validator: FormFieldValidatorProtocol = FormFieldValidator()

        func field(after currentField: FormTextField.Name?) -> FormTextField.Name? {
            switch currentField {
            case .title:
                return .theme
            case .theme, .link, .projectPicker, .none:
                return nil
            }
        }

        func save(_ values: ProjectForm.Values, for project: Project?, in context: ModelContext) throws {
            try self.validator.validate(values: (.title, values.title), (.theme, values.theme))

            if let project {
                self.updateProject(project, with: values)
            } else {
                self.createProject(with: values, in: context)
            }
        }
    }
}

// MARK: - Helpers

private extension ProjectForm.ViewModel {
    func createProject(with values: ProjectForm.Values, in context: ModelContext) {
        let project = Project(
            title: values.title.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: values.theme.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        context.insert(project)
    }

    func updateProject(_ project: Project, with values: ProjectForm.Values) {
        let title = values.title.trimmingCharacters(in: .whitespacesAndNewlines)
        let theme = values.theme.trimmingCharacters(in: .whitespacesAndNewlines)

        let hasChanges = title != project.title || theme != project.theme

        if hasChanges {
            project.title = title
            project.theme = theme
            project.updatedDate = .now
        }
    }
}
