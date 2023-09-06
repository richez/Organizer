//
//  ProjectCreatorViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import Foundation

struct ProjectCreatorField {
    var text: String
    var placeholder: String
}

struct ProjectCreatorFieldsDescription {
    var name: ProjectCreatorField
    var theme: ProjectCreatorField
}

struct ProjectCreatorViewModel {
    var fieldsDescription: ProjectCreatorFieldsDescription = .init(
        name: ProjectCreatorField(text: "Nom", placeholder: "Mon projet"),
        theme: ProjectCreatorField(text: "Thème", placeholder: "Sport, Construction, Travail")
    )

    func isFieldsValid(name: String, theme: String) -> Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            return true
        } else {
            return false
        }
    }
}
