//
//  ThemeTypeEntity.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import AppIntents
import Foundation

enum ThemeTypeEntity: String, AppEnum {
    case all
    case specific

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Theme List")
    static var caseDisplayRepresentations: [ThemeTypeEntity: DisplayRepresentation] = [
        .all: "All",
        .specific: "Specific"
    ]
}
