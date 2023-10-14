//
//  ContentFormViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 14/10/2023.
//

import Foundation

extension ContentForm {
    struct ViewModel {
        var linkConfiguration: FormTextField.Configuration = .init(
            name: .link,
            placeholder: "https://www.youtube.com",
            submitLabel: .next,
            errorMessage: "This field should start with http(s):// and be valid"
        )

        var titleConfiguration: FormTextField.Configuration = .init(
            name: .title,
            placeholder: "Your Project",
            submitLabel: .next,
            errorMessage: "This field cannot be empty"
        )

        var themeConfiguration: FormTextField.Configuration = .init(
            name: .theme,
            placeholder: "Sport, Construction, Work",
            submitLabel: .return,
            errorMessage: "This field is invalid"
        )

        func field(after currentField: FormTextField.Name?) -> FormTextField.Name? {
            switch currentField {
            case .link:
                return .title
            case .title:
                return .theme
            case .theme, .none:
                return nil
            }
        }
    }
}
