//
//  FormTextFieldConfiguration.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

extension FormTextField {
    struct Configuration {
        var name: String
        var errorMessage: String
    }
}

extension FormTextField.Configuration {
    static let projectTitle: Self = .init(
        name: String(localized: "Title"),
        errorMessage: String(localized: "This field cannot be empty")
    )

    static let projectTheme: Self = .init(
        name: String(localized: "Themes"),
        errorMessage: String(localized: "This field is invalid")
    )

    static let contentLink: Self = .init(
        name: String(localized: "Link"),
        errorMessage: String(localized: "This field should start with http(s):// and be valid")
    )

    static let contentTitle: Self = .init(
        name: String(localized: "Title"),
        errorMessage: String(localized: "This field cannot be empty")
    )

    static let contentTheme: Self = .init(
        name: String(localized: "Themes"),
        errorMessage: String(localized: "This field is invalid")
    )
}
