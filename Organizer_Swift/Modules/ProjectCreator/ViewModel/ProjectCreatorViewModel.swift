//
//  ProjectCreatorViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import Foundation

struct ProjectCreatorFieldsDescription {
    var name: (text: String, placeholder: String)
    var theme: (text: String, placeholder: String)
}

struct ProjectCreatorViewModel {
    var fieldsDescription: ProjectCreatorFieldsDescription = .init(
        name: ("Nom", "Mon projet"),
        theme: ("Thème", "Sport, Construction, Travail")
    )
}
