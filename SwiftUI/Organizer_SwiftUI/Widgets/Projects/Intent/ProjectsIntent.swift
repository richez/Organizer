//
//  ProjectsIntent.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import AppIntents
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
