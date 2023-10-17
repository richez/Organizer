//
//  FormTextFieldConfiguration.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

extension FormTextField {
    enum Name {
        case title
        case theme
        case link
        case projectPicker
    }

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
        placeholder: "My Project",
        submitLabel: .next,
        errorMessage: "This field cannot be empty",
        autoCapitalization: .words
    )

    static let projectTheme: Self = .init(
        name: .theme,
        placeholder: "DIY, sport, outdoor",
        submitLabel: .return,
        errorMessage: "This field is invalid",
        autoCapitalization: .never
    )

    static let contentLink: Self = .init(
        name: .link,
        placeholder: "https://www.youtube.com",
        submitLabel: .next,
        errorMessage: "This field should start with http(s):// and be valid",
        autoCapitalization: .never,
        keyboardType: .URL,
        autocorrectionDisabled: true
    )

    static let contentTitle: Self = .init(
        name: .title,
        placeholder: "My Content",
        submitLabel: .next,
        errorMessage: "This field cannot be empty",
        autoCapitalization: .words
    )

    static let contentTheme: Self = .init(
        name: .theme,
        placeholder: "spots, tools, build",
        submitLabel: .return,
        errorMessage: "This field is invalid",
        autoCapitalization: .never
    )

    static let projectPicker: Self = .init(
        name: .projectPicker,
        placeholder: "My Project",
        submitLabel: .return,
        errorMessage: "This field cannot be empty",
        autoCapitalization: .words
    )
}
