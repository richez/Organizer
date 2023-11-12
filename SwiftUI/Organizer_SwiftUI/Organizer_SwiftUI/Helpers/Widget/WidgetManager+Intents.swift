//
//  WidgetManager+Intents.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/11/2023.
//

import Foundation
import WidgetKit

// cf WidgetManager+Intents file in Share Extension target for more info.
extension WidgetManager {
    func projectsIntentTheme(from widget: WidgetInfo) -> String? {
        widget.widgetConfigurationIntent(of: ProjectsIntent.self)?.theme?.name
    }

    func singleProjectIntentIdentifier(from widget: WidgetInfo) -> UUID? {
        widget.widgetConfigurationIntent(of: SingleProjectIntent.self)?.project?.id
    }
}
