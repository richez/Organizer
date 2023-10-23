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
        var store: ProjectStoreWritter = ProjectStore.shared
        var validator: FormFieldValidatorProtocol = FormFieldValidator()

        func field(after currentField: FormTextField.Name?) -> FormTextField.Name? {
            switch currentField {
            case .title:
                return .theme
            case .theme, .link, .projectPicker, .none:
                return nil
            }
        }

        func save(_ values: ProjectValues, for project: Project?, in context: ModelContext) throws {
            try self.validator.validate(values: (.title, values.title), (.theme, values.theme))

            if let project {
                self.store.update(project, with: values)
            } else {
                self.store.create(with: values, in: context)
            }
        }
    }
}
