//
//  FormTextFieldConfiguration.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

extension FormTextField {
    struct Configuration {
        var name: LocalizedStringKey
        var errorMessage: LocalizedStringKey
    }
}

extension FormTextField.Configuration {
    static let projectTitle: Self = .init(
        name: "Title",
        errorMessage: "This field cannot be empty"
    )

    static let projectTheme: Self = .init(
        name: "Themes",
        errorMessage: "This field is invalid"
    )

    static let contentLink: Self = .init(
        name: "Link",
        errorMessage: "This field should start with http(s):// and be valid"
    )

    static let contentTitle: Self = .init(
        name: "Title",
        errorMessage: "This field cannot be empty"
    )

    static let contentTheme: Self = .init(
        name: "Themes",
        errorMessage: "This field is invalid"
    )
}
