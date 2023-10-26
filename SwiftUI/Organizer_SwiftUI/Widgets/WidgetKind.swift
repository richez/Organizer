//
//  WidgetKind.swift
//  WidgetsExtension
//
//  Created by Thibaut Richez on 26/10/2023.
//

import SwiftUI
import WidgetKit

enum WidgetKind: String {
    case addProject = "Add Project Widget"
    case lastProject = "Last Project Widget"
    case projects = "Projects Widget"
    case singleProject = "Single Project Widget"

    var displayName: String {
        switch self {
        case .addProject: "Create Project"
        case .lastProject: "Last Project"
        case .projects: "Projects"
        case .singleProject: "Single Project"
        }
    }

    var description: String {
        switch self {
        case .addProject: "Add a new project to Organizer and start creating content"
        case .lastProject: "Quick access to the most recently edited project"
        case .projects: "Display recent projects from any Organizer tag"
        case .singleProject: "Pick a single project for quick access from the home screen"
        }
    }
}

extension StaticConfiguration {
    init<Provider>(
        kind: WidgetKind,
        provider: Provider,
        @ViewBuilder content: @escaping (Provider.Entry) -> Content
    ) where Provider : TimelineProvider {
        self.init(kind: kind.rawValue, provider: provider, content: content)
    }
}

extension AppIntentConfiguration {
    init<Provider>(
        kind: WidgetKind,
        intent: Intent.Type = Intent.self,
        provider: Provider,
        @ViewBuilder content: @escaping (Provider.Entry) -> Content
    ) where Intent == Provider.Intent, Provider : AppIntentTimelineProvider {
        self.init(kind: kind.rawValue, intent: intent, provider: provider, content: content)
    }
}

extension WidgetConfiguration {
    func configurationDisplayName(for kind: WidgetKind) -> some WidgetConfiguration {
        self.configurationDisplayName(kind.displayName)
    }

    func description(for kind: WidgetKind) -> some WidgetConfiguration {
        self.description(kind.description)
    }
}
