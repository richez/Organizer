//
//  ProjectFormViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import Foundation

struct ProjectFormViewModel {
    private let mode: ProjectFormMode
    private let dataStore: ProjectDataStoreCreator
    private let notificationCenter: NotificationCenter

    init(mode: ProjectFormMode,
         dataStore: ProjectDataStoreCreator = ProjectDataStore.shared,
         notificationCenter: NotificationCenter = .default) {
        self.mode = mode
        self.dataStore = dataStore
        self.notificationCenter = notificationCenter
    }
}

// MARK: - Public

extension ProjectFormViewModel {
    var viewConfiguration: ProjectFormViewConfiguration {
        .init(
            saveImageName: "checkmark",
            fields: ProjectFormFieldsConfiguration(
                name: ProjectFormField(
                    text: "Name", placeholder: "My project", value: self.nameFieldValue
                ),
                theme: ProjectFormField(
                    text: "Themes", placeholder: "Sport, Construction, Work", value: self.themeFieldValue
                )
            )
        )
    }

    func isFieldsValid(name: String, theme: String) -> Bool {
        switch self.mode {
        case .create:
            let isValidName = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            let isValidTheme = true
            return isValidName && isValidTheme
        case .update(let project):
            let isValidName = name.trimmingCharacters(in: .whitespacesAndNewlines) != project.title
            let isValidTheme = theme.trimmingCharacters(in: .whitespacesAndNewlines) != project.theme
            return isValidName || isValidTheme
        }
    }

    func commit(name: String, theme: String) throws {
        switch self.mode {
        case .create:
            try self.createProject(name: name, theme: theme)
        case .update(let project):
            self.updateProject(project, name: name, theme: theme)
        }
    }
}

// MARK: - Helpers

private extension ProjectFormViewModel {
    // MARK: Fields

    var nameFieldValue: String? {
        switch self.mode {
        case .create:
            return nil
        case .update(let project):
            return project.title
        }
    }

    var themeFieldValue: String? {
        switch self.mode {
        case .create:
            return nil
        case .update(let project):
            return project.theme
        }
    }

    // MARK: Project

    func createProject(name: String, theme: String) throws {
        let project = Project(
            id: UUID(),
            title: name.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: theme.trimmingCharacters(in: .whitespacesAndNewlines),
            contents: [],
            creationDate: .now,
            lastUpdatedDate: .now
        )

        do {
            try self.dataStore.create(project: project)
            self.notificationCenter.post(name: .didCreateProject, object: nil)
        } catch {
            throw ProjectFormViewModelError.create(error)
        }
    }

    func updateProject(_ project: Project, name: String, theme: String) {
        project.title = name.trimmingCharacters(in: .whitespacesAndNewlines)
        project.theme = theme.trimmingCharacters(in: .whitespacesAndNewlines)
        project.lastUpdatedDate = .now
        self.notificationCenter.post(name: .didUpdateProject, object: nil)
    }
}
