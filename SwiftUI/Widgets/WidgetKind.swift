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

    var displayName: LocalizedStringKey {
        switch self {
        case .addProject: "Create Project"
        case .lastProject: "Last Project"
        case .projects: "Projects"
        case .singleProject: "Single Project"
        }
    }

    var description: LocalizedStringKey {
        switch self {
        case .addProject: "Add a new project to Organizer and start adding content"
        case .lastProject: "Quick access to the most recently edited project"
        case .projects: "Display recent projects from any Organizer theme"
        case .singleProject: "Pick a single project for quick access from the home screen"
        }
    }
}
