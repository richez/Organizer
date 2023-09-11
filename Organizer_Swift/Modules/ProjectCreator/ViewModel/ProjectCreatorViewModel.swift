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
    private let dataStore: ProjectDataStoreCreator

    init(dataStore: ProjectDataStoreCreator = ProjectDataStore.shared) {
        self.dataStore = dataStore
    }
}

// MARK: - Public

extension ProjectCreatorViewModel {
    var fieldsDescription: ProjectCreatorFieldsDescription {
        ProjectCreatorFieldsDescription(
            name: ProjectCreatorField(text: "Nom", placeholder: "Mon projet"),
            theme: ProjectCreatorField(text: "Thème", placeholder: "Sport, Construction, Travail")
        )
    }

    func isFieldsValid(name: String, theme: String) -> Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            return true
        } else {
            return false
        }
    }

    func saveProject(name: String, theme: String) throws {
        let projectName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let projectTheme: String? = {
            let theme = theme.trimmingCharacters(in: .whitespacesAndNewlines)
            return theme.isEmpty ? nil : theme
        }()

        let project = Project(title: projectName, theme: projectTheme, lastUpdatedDate: .now)
        try self.dataStore.create(project: project)
    }
}
