//
//  ContentFormViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 14/10/2023.
//

import Foundation
import SwiftData

extension ContentForm {
    struct ViewModel {
        var store: ContentStoreWritter = ContentStore.shared
        var validator: FormFieldValidatorProtocol = FormFieldValidator()
        var urlMetadataProvider: URLMetadataProviderProtocol = URLMetadataProvider()

        func isValidURL(_ text: String) -> Bool {
            text.isValidURL()
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

        func title(of link: String) async throws -> String {
            return try await self.urlMetadataProvider.title(of: link)
        }

        func save(
            _ values: ContentFormValues,
            for content: ProjectContent?,
            in project: Project,
            context: ModelContext
        ) throws {
            try self.validator.validate(values: (.link, values.link), (.title, values.title), (.theme, values.theme))

            let url = URL(string: values.link)!
            let values = ContentValues(type: values.type, url: url, title: values.title, theme: values.theme)

            if let content {
                self.store.update(content, with: values)
            } else {
                self.store.create(with: values, in: project, context: context)
            }
        }
    }
}
