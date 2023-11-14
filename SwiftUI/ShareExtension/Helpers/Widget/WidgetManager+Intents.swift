//
//  WidgetManager+Intents.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 12/11/2023.
//

import Foundation
import WidgetKit

// Adding 'WidgetConfigurationIntent' types to the Share Extension target produce
// a bug in the associated widgets that are always displayed in placeholder mode
// and cannot be edited.
// The project builds but the following error is logged at runtime:
// "Could not find an intent with identifier xxxIntent, mangledTypeName: ..."
// To avoid this issue, 'nil' is returned from the below methods and the installed
// widgets are always reloaded when a change occurs in the database (i.e. a project
// or content is created) even if the associated widget doesn't need to.
extension WidgetManager {
    func projectsIntentTheme(from widget: WidgetInfo) -> String? { nil }
    func singleProjectIntentIdentifier(from widget: WidgetInfo) -> UUID? { nil }
}
