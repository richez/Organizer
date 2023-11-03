//
//  ThemeType.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import AppIntents
import Foundation

enum ThemeType: String, AppEnum {
    case all
    case specific

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Theme List")
    static var caseDisplayRepresentations: [ThemeType : DisplayRepresentation] = [
        .all: "All",
        .specific: "Specific"
    ]
}
