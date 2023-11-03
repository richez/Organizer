//
//  TagEntity.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import AppIntents
import Foundation

struct TagEntity: AppEntity, Identifiable {
    var name: String
    var id: String { self.name }

    var displayRepresentation: DisplayRepresentation {
        .init(stringLiteral: self.name)
    }
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Tag")
    static var defaultQuery = TagEntityQuery()
}
