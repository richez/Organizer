//
//  PreviewDataGenerator.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation
import SwiftData

private extension Date {
    func adding(_ value: Int, to component: Calendar.Component = .day) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
}

enum PreviewDataGenerator {
    static var project: Project = .init(
        title: "Self-Build",
        theme: "DIY",
        createdDate: .now.adding(-1, to: .day).adding(-2, to: .month).adding(-3, to: .hour).adding(-4, to: .minute), 
        updatedDate: .now
    )

    static var content: ProjectContent = .init(
        type: .video, 
        title: "How to choose your insulation materials ?",
        theme: "insulation",
        url: URL(string: "https://www.hackingwithswift.com")!
    )

    static func generateData(in context: ModelContext) {
        let selfBuild = project
        let hiking = Project(title: "Hiking", theme: "Sport, Outdoor", updatedDate: .now.adding(-1))
        let bicycle = Project(title: "Bicycle", theme: "Sport, Outdoor", updatedDate: .now.adding(-2))
        let jobs = Project(title: "Jobs", updatedDate: .now.adding(-3))

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
            ProjectContent(
                type: .article, title: "How to choose your insulation materials ?",
                theme: "insulation",
                url: URL(string: "https://www.youtube.com")!
            ),
            ProjectContent(
                type: .video,
                title: "The type of screws you should know",
                theme: "tools",
                url: URL(string: "https://www.youtube.com")!
            ),
            ProjectContent(
                type: .note,
                title: "First time building stairs",
                url: URL(string: "https://www.youtube.com")!
            ),
            ProjectContent(
                type: .other,
                title: "How to find the right self-build land",
                theme: "land",
                url: URL(string: "https://www.youtube.com")!
            ),
        ]
    }

    private static var hikingContents: [ProjectContent] {
        [
            ProjectContent(
                type: .note,
                title: "The best hiking spots",
                theme: "spots",
                url: URL(string: "https://www.youtube.com")!
            ),
            ProjectContent(
                type: .article,
                title: "The best backpack gear list",
                theme: "gear",
                url: URL(string: "https://www.youtube.com")!
            )
        ]
    }

    private static var bicycleContents: [ProjectContent] {
        [
            ProjectContent(
                type: .other,
                title: "The best cycling spots",
                theme: "spots",
                url: URL(string: "https://www.youtube.com")!
            ),
            ProjectContent(
                type: .video,
                title: "The best backpack gear list",
                theme: "gear",
                url: URL(string: "https://www.youtube.com")!
            )
        ]
    }
}
