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
            name: ProjectCreatorField(text: "Name", placeholder: "My project"),
            theme: ProjectCreatorField(text: "Theme", placeholder: "Sport, Construction, Work")
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

        let project = Project(
            id: UUID(),
            title: projectName,
            theme: projectTheme,
            creationDate: .now,
            lastUpdatedDate: .now
        )
        try self.dataStore.create(project: project)
    }
}
