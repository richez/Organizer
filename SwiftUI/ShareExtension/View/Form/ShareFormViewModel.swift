//
//  ShareFormViewModel.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import Foundation
import OSLog
import SwiftData

extension ShareForm {
    @Observable
    final class ViewModel {
        // MARK: - Properties

        private let content: ShareContent
        private let contentStore: ContentStoreWritter
        private let contentFormatter: ContentFormatterProtocol
        private let projectStore: ProjectStoreWritter
        private let projectFormatter: ProjectFormatterProtocol
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
        var error: Swift.Error? = nil
        @ObservationIgnored var didSaveContent: Bool = false

        // MARK: - Initialization

        init(
            content: ShareContent,
            contentStore: ContentStoreReader & ContentStoreWritter = ContentStore(),
            contentFormatter: ContentFormatterProtocol = ContentFormatter(),
            projectStore: ProjectStoreWritter = ProjectStore(),
            projectFormatter: ProjectFormatterProtocol = ProjectFormatter(),
            validator: FormFieldValidatorProtocol = FormFieldValidator()
        ) {
            self.content = content
            self.contentStore = contentStore
            self.contentFormatter = contentFormatter
            self.projectStore = projectStore
            self.projectFormatter = projectFormatter
            self.validator = validator
        }

        // MARK: - Public

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
                let values = self.contentFormatter.values(
                    type: self.type, url: URL(string: self.link)!, title: self.title, theme: self.theme
                )
                try self.save(values, in: context)
                self.didSaveContent = true
            } catch FormFieldValidator.Error.invalidFields(let fields) {
                self.isInvalidLink = fields.contains(.link)
                self.isInvalidTitle = fields.contains(.title)
                self.isInvalidTheme = fields.contains(.theme)
                self.isInvalidProjectTitle = fields.contains(.projectPicker)
                Logger.forms.info("Fail to validate share form with invalid fields: \(fields)")
            } catch {
                self.error = Error.save(error)
                Logger.forms.info("Fail to validate share form with error: \(error)")
            }
        }
    }
}

// MARK: - Helpers

private extension ShareForm.ViewModel {
    enum SelectedProject {
        case new(String)
        case custom(Project)
    }

    func save(_ values: ContentValues, in context: ModelContext) throws {
        let project: SelectedProject = switch self.selectedProject {
        case .none: .new(self.projectTitle)
        case .some(let project): .custom(project)
        }

        switch project {
        case .new(let title):
            try self.validator.validate(values: (.projectPicker, title))
            let project = self.projectFormatter.project(from: .init(title: title))
            let content = self.contentFormatter.content(from: values)
            self.projectStore.create(project, contents: [content], in: context)

        case .custom(let project):
            let content = self.contentFormatter.content(from: values)
            self.contentStore.create(content, in: project, context: context)
        }
    }
}

// MARK: - Error

extension ShareForm.ViewModel {
    enum Error: LocalizedError {
        case save(Swift.Error)

        var errorDescription: String? {
            switch self {
            case .save: String(localized: "Fail to save content")
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .save: String(localized: "Check that the provided fields are valid and try again")
            }
        }
    }
}
