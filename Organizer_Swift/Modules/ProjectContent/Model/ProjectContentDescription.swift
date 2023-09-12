//
//  ProjectContentDescription.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import Foundation

struct ProjectContentDescription: Hashable {
    var id: UUID
    var typeImageName: String
    var title: String
    var theme: String?
}

extension ProjectContentDescription {
    static let sample: [ProjectContentDescription] = [
        .init(id: UUID(), typeImageName: "newspaper", title: "Quel isolant choisir", theme: "#Isolation"),
        .init(id: UUID(), typeImageName: "note", title: "Fondations d'une tiny house", theme: "#Foundation"),
        .init(id: UUID(), typeImageName: "video", title: "Les differents types de vis", theme: "#Outillage"),
        .init(id: UUID(), typeImageName: "questionmark.square", title: "Laine de verre avantages et inconvenient", theme: "#Isolation")
    ]
}
