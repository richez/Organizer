//
//  ShareFormViewModel.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import Foundation
import SwiftData

extension ShareForm {
    struct ViewModel {
        var contentStore: ContentStoreReader & ContentStoreWritter = ContentStore.shared
        var projectStore: ProjectStoreWritter = ProjectStore.shared
        var validator: FormFieldValidatorProtocol = FormFieldValidator()

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

        func save(_ values: ContentValues, project: SelectedProject, in context: ModelContext) throws {
            try self.validator.validate(values: (.link, values.link), (.title, values.title), (.theme, values.theme))

            switch project {
            case .new(let title):
                try self.validator.validate(values: (.projectPicker, title))
                let content = self.contentStore.content(with: values)
                self.projectStore.create(with: .init(title: title), contents: [content], in: context)

            case .custom(let project):
                self.contentStore.create(with: values, for: project, in: context)
            }
        }
    }
}
