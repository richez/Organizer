//
//  ContentFormViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 25/10/2023.
//

import Foundation
import SwiftData

extension ContentForm {
    @Observable
    final class ViewModel {
        private let project: Project
        private let content: ProjectContent?
        private let store: ContentStoreWritter
        private let validator: FormFieldValidatorProtocol
        private let urlMetadataProvider: URLMetadataProviderProtocol

        var type: ProjectContentType = .article
        var link: String = ""
        var title: String = ""
        var theme: String = ""
        var isInvalidLink: Bool = false
        var isInvalidTitle: Bool = false
        var isInvalidTheme: Bool = false
        var hasUnknownError: Bool = false
        var shouldLoadTitle: Bool = false
        var isLoadingTitle: Bool = false
        @ObservationIgnored var didSaveContent: Bool = false

        init(
            project: Project,
            content: ProjectContent?,
            store: ContentStoreWritter = ContentStore.shared,
            validator: FormFieldValidatorProtocol = FormFieldValidator(),
            urlMetadataProvider: URLMetadataProviderProtocol = URLMetadataProvider()
        ) {
            self.project = project
            self.content = content
            self.store = store
            self.validator = validator
            self.urlMetadataProvider = urlMetadataProvider
        }

        var isValidURL: Bool { self.link.isValidURL() }

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
            if let content {
                self.type = content.type
                self.link = content.url.absoluteString
                self.title = content.title
                self.theme = content.theme
            }
        }

        func loadLinkTitle() async {
            guard self.shouldLoadTitle, !self.isLoadingTitle else { return }

            do {
                self.isLoadingTitle = true
                let linkTitle = try await self.urlMetadataProvider.title(of: self.link)
                try Task.checkCancellation()
                self.title = linkTitle
                self.isLoadingTitle = false
                self.shouldLoadTitle = false
            } catch {
                self.isLoadingTitle = false
                self.shouldLoadTitle = false
                self.hasUnknownError = true
            }
        }

        func save(in context: ModelContext) {
            do {
                try self.validator.validate(values: (.link, self.link), (.title, self.title), (.theme, self.theme))
                let values = ContentValues(
                    type: self.type, url: URL(string: self.link)!, title: self.title, theme: self.theme
                )
                self.save(values, in: context)
                self.didSaveContent = true
            } catch FormFieldValidator.Error.invalidFields(let fields) {
                self.isInvalidLink = fields.contains(.link)
                self.isInvalidTitle = fields.contains(.title)
                self.isInvalidTheme = fields.contains(.theme)
            } catch {
                self.hasUnknownError = true
            }
        }
    }
}

private extension ContentForm.ViewModel {
    func save(_ values: ContentValues, in context: ModelContext) {
        if let content {
            self.store.update(content, with: values)
        } else {
            self.store.create(with: values, in: self.project, context: context)
        }
    }

}
