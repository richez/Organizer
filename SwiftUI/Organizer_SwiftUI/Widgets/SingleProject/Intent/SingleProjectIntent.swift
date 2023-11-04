//
//  SingleProjectIntent.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 04/11/2023.
//

import AppIntents
import WidgetKit

struct SingleProjectIntent: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Project"
    static let description = IntentDescription("Keep track of a specific project.")

    @Parameter(title: "Project")
    var project: ProjectEntity?
}
