//
//  FormTextFieldConfiguration.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

extension FormTextField {
    struct Configuration {
        var name: Name
        var placeholder: String
        var submitLabel: SubmitLabel
        var errorMessage: String

        var autoCapitalization: TextInputAutocapitalization = .sentences
        var keyboardType: UIKeyboardType = .default
        var autocorrectionDisabled: Bool = false
    }
}

extension FormTextField.Configuration {
    static let projectTitle: Self = .init(
        name: .title,
        placeholder: String(localized: "My Project"),
        submitLabel: .next,
        errorMessage: String(localized: "This field cannot be empty"),
        autoCapitalization: .words
    )

    static let projectTheme: Self = .init(
        name: .theme,
        placeholder: String(localized: "DIY, sport, outdoor"),
        submitLabel: .return,
        errorMessage: String(localized: "This field is invalid"),
        autoCapitalization: .never
    )

    static let contentLink: Self = .init(
        name: .link,
        placeholder: "https://www.youtube.com",
        submitLabel: .next,
        errorMessage: String(localized: "This field should start with http(s):// and be valid"),
        autoCapitalization: .never,
        keyboardType: .URL,
        autocorrectionDisabled: true
    )

    static let contentTitle: Self = .init(
        name: .title,
        placeholder: String(localized: "My Content"),
        submitLabel: .next,
        errorMessage: String(localized: "This field cannot be empty"),
        autoCapitalization: .sentences
    )

    static let contentTheme: Self = .init(
        name: .theme,
        placeholder: String(localized: "spots, tools, build"),
        submitLabel: .return,
        errorMessage: String(localized: "This field is invalid"),
        autoCapitalization: .never
    )

    static let projectPicker: Self = .init(
        name: .projectPicker,
        placeholder: String(localized: "My Project"),
        submitLabel: .return,
        errorMessage: String(localized: "This field cannot be empty"),
        autoCapitalization: .words
    )
}
