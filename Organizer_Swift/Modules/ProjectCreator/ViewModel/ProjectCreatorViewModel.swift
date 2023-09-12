//
//  ProjectCreatorViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import Foundation

enum ProjectCreatorViewModelError: RenderableError {
    case create(Error)

    var title: String { "Fail to create project" }
    var message: String { "Please try again later" }
    var actionTitle: String { "OK" }
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
        .init(
            name: ProjectCreatorField(text: "Name", placeholder: "My project"),
            theme: ProjectCreatorField(text: "Theme", placeholder: "Sport, Construction, Work")
        )
    }

    func isFieldsValid(name: String, theme: String) -> Bool {
        let isValidName = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isValidTheme = true
        return isValidName && isValidTheme
    }

    func createProject(name: String, theme: String) throws {
        let projectName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let projectTheme = theme.trimmingCharacters(in: .whitespacesAndNewlines)

        let project = Project(
            id: UUID(),
            title: projectName,
            theme: projectTheme, 
            contents: [],
            creationDate: .now,
            lastUpdatedDate: .now
        )

        do {
            try self.dataStore.create(project: project)
        } catch {
            throw ProjectCreatorViewModelError.create(error)
        }
    }
}
