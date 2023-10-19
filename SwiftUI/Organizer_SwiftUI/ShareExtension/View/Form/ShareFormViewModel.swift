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

        func save(_ values: Values, in context: ModelContext) throws {
            try self.validator.validate(values: (.link, values.link), (.title, values.title), (.theme, values.theme))
            let content = self.content(with: values)

            switch values.project {
            case .new(let title):
                try self.createProject(with: title, content: content, in: context)
            case .custom(let project):
                self.addContent(content, to: project, in: context)
            }
        }
    }
}

private extension ShareForm.ViewModel {
    func content(with values: ShareForm.Values) -> ProjectContent {
        .init(
            type: values.type,
            title: values.title.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: values.theme.trimmingCharacters(in: .whitespacesAndNewlines),
            link: values.link.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

    func createProject(with title: String, content: ProjectContent, in context: ModelContext) throws {
        try self.validator.validate(values: (.projectPicker, title))

        let project = Project(title: title)
        context.insert(project)

        content.project = project
        project.contents = [content]
    }

    func addContent(_ content: ProjectContent, to project: Project, in context: ModelContext) {
        project.updatedDate = .now
        content.project = project
        context.insert(content)
        project.contents.append(content)
    }
}
