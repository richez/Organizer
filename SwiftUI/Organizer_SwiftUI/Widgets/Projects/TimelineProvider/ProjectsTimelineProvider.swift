//
//  ProjectsTimelineProvider.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 03/11/2023.
//

import WidgetKit

struct ProjectsTimelineProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> ProjectsEntry {
        ProjectsEntry(projects: [])
    }
    
    func snapshot(for configuration: ProjectsIntent, in context: Context) async -> ProjectsEntry {
        ProjectsEntry(projects: [])
    }
    
    func timeline(for configuration: ProjectsIntent, in context: Context) async -> Timeline<ProjectsEntry> {
        Timeline(entries: [ProjectsEntry(projects: [])], policy: .never)
    }
}
