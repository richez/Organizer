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

    @Parameter(title: "Themes", default: .all)
    var type: ThemeTypeEntity

    @Parameter(title: "Theme")
    var theme: ThemeEntity?

    static var parameterSummary:  some ParameterSummary {
        When(\.$type, .equalTo, ThemeTypeEntity.specific) {
            Summary {
                \.$type
                \.$theme
            }
        } otherwise: {
            Summary {
                \.$type
            }
        }
    }
}
