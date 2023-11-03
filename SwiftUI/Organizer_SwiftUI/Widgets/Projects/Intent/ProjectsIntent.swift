//
//  ProjectsIntent.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import AppIntents
import Foundation
import WidgetKit

struct ProjectsIntent: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Project"
    static let description = IntentDescription("Keep track of your projects.")

    @Parameter(title: "Tags", default: .all)
    var type: TagType

    @Parameter(title: "Tag")
    var tag: TagEntity?

    static var parameterSummary:  some ParameterSummary {
        When(\.$type, .equalTo, TagType.specific) {
            Summary {
                \.$type
                \.$tag
            }
        } otherwise: {
            Summary {
                \.$type
            }
        }
    }
}

struct TagEntity: AppEntity, Identifiable {
    var name: String
    var id: String { self.name }

    var displayRepresentation: DisplayRepresentation {
        .init(stringLiteral: self.name)
    }
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Tag")
    static var defaultQuery = TagEntityQuery()
}

struct TagEntityQuery: EntityQuery {
    func entities(for identifiers: [TagEntity.ID]) async throws -> [TagEntity] {
        return identifiers.map(TagEntity.init(name:))
    }

    func suggestedEntities() async throws -> [TagEntity] {
        let store = WidgetStore()
        let formatter = ProjectFormatter()
        let projects = try store.projects(propertiesToFetch: [\.theme])
        let themes = formatter.themes(from: projects)
        return themes.map(TagEntity.init(name:))
    }
}

enum TagType: String, AppEnum {
    case all
    case specific

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Tag List")
    static var caseDisplayRepresentations: [TagType : DisplayRepresentation] = [
        .all: "All",
        .specific: "Specific"
    ]
}

// TODO: remove singleton ?
// TODO: RectangularView: use .frame(maxWidth: .infinity, alignment: .topLeading) instead of nested HStack ?
// TODO: WidgetStore: make container static
