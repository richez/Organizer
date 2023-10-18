//
//  FormTextFieldConfiguration.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import Foundation

extension FormTextField {
    struct Configuration {
        var name: String
        var errorMessage: String
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
}
