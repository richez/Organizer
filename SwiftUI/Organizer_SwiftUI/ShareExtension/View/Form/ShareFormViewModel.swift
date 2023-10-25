//
//  ShareFormViewModel.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import Foundation
import SwiftData

extension ShareForm {
    @Observable
    final class ViewModel {
        private let content: ShareContent
        private let contentStore: ContentStoreReader & ContentStoreWritter
        private let projectStore: ProjectStoreWritter
        private let validator: FormFieldValidatorProtocol

        var projectTitle: String = ""
        var isInvalidProjectTitle: Bool = false
        var selectedProject: Project?
        var type: ProjectContentType = .article
        var link: String = ""
        var title: String = ""
        var theme: String = ""
        var isInvalidLink: Bool = false
        var isInvalidTitle: Bool = false
        var isInvalidTheme: Bool = false
        var hasUnknownError: Bool = false
        @ObservationIgnored var didSaveContent: Bool = false

        init(
            content: ShareContent,
            contentStore: ContentStoreReader & ContentStoreWritter = ContentStore.shared,
            projectStore: ProjectStoreWritter = ProjectStore.shared,
            validator: FormFieldValidatorProtocol = FormFieldValidator()
        ) {
            self.content = content
            self.contentStore = contentStore
            self.projectStore = projectStore
            self.validator = validator
        }

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

        func update() {
            self.title = self.content.title
            self.link = self.content.url
        }

        func save(in context: ModelContext) {
            do {
                try self.validator.validate(values: (.link, self.link), (.title, self.title), (.theme, self.theme))
                let values = ContentValues(
                    type: self.type, url: URL(string: self.link)!, title: self.title, theme: self.theme
                )
                try self.save(values, in: context)
                self.didSaveContent = true
            } catch FormFieldValidator.Error.invalidFields(let fields) {
                self.isInvalidLink = fields.contains(.link)
                self.isInvalidTitle = fields.contains(.title)
                self.isInvalidTheme = fields.contains(.theme)
                self.isInvalidProjectTitle = fields.contains(.projectPicker)
            } catch {
                self.hasUnknownError = true
            }
        }
    }
}

private extension ShareForm.ViewModel {
    enum SelectedProject: Hashable, Identifiable {
        case new(String)
        case custom(Project)

        var id: SelectedProject { self }
    }

    func save(_ values: ContentValues, in context: ModelContext) throws {
        let project: SelectedProject = switch self.selectedProject {
        case .none: .new(self.projectTitle)
        case .some(let project): .custom(project)
        }

        switch project {
        case .new(let title):
            try self.validator.validate(values: (.projectPicker, title))
            let content = self.contentStore.content(with: values)
            self.projectStore.create(with: .init(title: title), contents: [content], in: context)

        case .custom(let project):
            self.contentStore.create(with: values, in: project, context: context)
        }
    }
}
