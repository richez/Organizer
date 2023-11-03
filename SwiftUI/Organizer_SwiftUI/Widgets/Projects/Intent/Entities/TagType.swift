//
//  TagType.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import AppIntents
import Foundation

enum TagType: String, AppEnum {
    case all
    case specific

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Tag List")
    static var caseDisplayRepresentations: [TagType : DisplayRepresentation] = [
        .all: "All",
        .specific: "Specific"
    ]
}
