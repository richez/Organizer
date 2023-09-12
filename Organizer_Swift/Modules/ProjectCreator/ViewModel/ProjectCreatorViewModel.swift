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
    private let notificationCenter: NotificationCenter

    init(dataStore: ProjectDataStoreCreator = ProjectDataStore.shared,
         notificationCenter: NotificationCenter = .default) {
        self.dataStore = dataStore
        self.notificationCenter = notificationCenter
    }
}

// MARK: - Public

extension ProjectCreatorViewModel {
    var fieldsDescription: ProjectCreatorFieldsDescription {
        .init(
            name: ProjectCreatorField(text: "Name", placeholder: "My project"),
            theme: ProjectCreatorField(text: "Themes", placeholder: "Sport, Construction, Work")
        )
    }

    func isFieldsValid(name: String, theme: String) -> Bool {
        let isValidName = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isValidTheme = true
        return isValidName && isValidTheme
    }

    func createProject(name: String, theme: String) throws {
        let project = Project(
            id: UUID(),
            title: name.trimmingCharacters(in: .whitespacesAndNewlines),
            themes: theme.words,
            contents: [],
            creationDate: .now,
            lastUpdatedDate: .now
        )

        do {
            try self.dataStore.create(project: project)
            self.notificationCenter.post(name: .didCreateProject, object: nil)
        } catch {
            throw ProjectCreatorViewModelError.create(error)
        }
    }
}
