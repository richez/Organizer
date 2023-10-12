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
    }

    struct Configuration {
        var name: Name
        var sectionName: String
        var placeholder: String
        var submitLabel: SubmitLabel
        var errorMessage: String
    }
}
