//
//  ProjectContentCreatorViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import Foundation

struct ProjectContentCreatorViewModel {
}

extension ProjectContentCreatorViewModel {
    var fieldsDescription: ProjectContentCreatorFieldsDescription {
        .init(
            type: ProjectContentCreatorMenu(text: "Type", items: ProjectContentType.allCases.map(\.rawValue)),
            name: ProjectContentCreatorField(text: "Name", placeholder: "My project"),
            theme: ProjectContentCreatorField(text: "Theme", placeholder: "Sport, Construction, Work"),
            link: ProjectContentCreatorField(text: "Link", placeholder: "https://www.youtube.com")
        )
    }
}
