//
//  PreviewDataGenerator.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation
import SwiftData

private extension Calendar {
    static func date(byAdding value: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: value, to: .now)!
    }
}

enum PreviewDataGenerator {
    static var project: Project = .init(title: "Self-Build", theme: "DIY", updatedDate: .now)
    static var content: ProjectContent = .init(type: .article, title: "How to choose your insulation materials ?", theme: "insulation")

    static func generateData(in context: ModelContext) {
        let selfBuild = project
        let hiking = Project(title: "Hiking", theme: "Sport, Outdoor", updatedDate: Calendar.date(byAdding: -1))
        let bicycle = Project(title: "Bicycle", theme: "Sport, Outdoor", updatedDate: Calendar.date(byAdding: -2))
        let jobs = Project(title: "Jobs", updatedDate: Calendar.date(byAdding: -3))

        [selfBuild, hiking, bicycle, jobs].forEach { context.insert($0) }

        addContent(selfBuildContents, in: selfBuild)
        addContent(hikingContents, in: hiking)
        addContent(bicycleContents, in: bicycle)
    }

    private static func addContent(_ contents: [ProjectContent], in project: Project) {
        contents.forEach { $0.project = project }
        project.contents = contents
    }

    private static var selfBuildContents: [ProjectContent] {
        [
            ProjectContent(type: .article, title: "How to choose your insulation materials ?", theme: "insulation"),
            ProjectContent(type: .video, title: "The type of screws you should know", theme: "tools"),
            ProjectContent(type: .note, title: "First time building stairs"),
            ProjectContent(type: .other, title: "How to find the right self-build land", theme: "land"),
        ]
    }

    private static var hikingContents: [ProjectContent] {
        [
            ProjectContent(type: .note, title: "The best hiking spots", theme: "spots"),
            ProjectContent(type: .article, title: "The best backpack gear list", theme: "gear")
        ]
    }

    private static var bicycleContents: [ProjectContent] {
        [
            ProjectContent(type: .other, title: "The best cycling spots", theme: "spots"),
            ProjectContent(type: .video, title: "The best backpack gear list", theme: "gear")
        ]
    }
}
