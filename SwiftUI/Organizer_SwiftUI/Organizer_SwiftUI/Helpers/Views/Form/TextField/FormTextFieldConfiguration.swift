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
