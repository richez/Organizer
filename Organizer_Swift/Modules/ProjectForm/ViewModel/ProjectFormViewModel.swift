//
//  ProjectFormViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import Foundation

struct ProjectFormViewModel {
    private let mode: ProjectFormMode
    private let dataStore: DataStoreCreator
    private let notificationCenter: NotificationCenter

    init(mode: ProjectFormMode,
         dataStore: DataStoreCreator = ProjectDataStore.shared,
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
            saveButtonImageName: "checkmark",
            fields: ProjectFormFieldsConfiguration(
                name: ProjectFormField(
                    text: "Name", placeholder: "My project", value: self.nameFieldValue, tag: 1
                ),
                theme: ProjectFormField(
                    text: "Themes", placeholder: "Sport, Construction, Work", value: self.themeFieldValue, tag: 2
                )
            )
        )
    }

    func isFieldsValid(for values: ProjectFormFieldValues) -> Bool {
        let name = values.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let theme = values.theme.trimmingCharacters(in: .whitespacesAndNewlines)

        switch self.mode {
        case .create:
            let isValidName = !name.isEmpty
            let isValidTheme = true
            return isValidName && isValidTheme
        case .update(let project):
            let isValidName = !name.isEmpty && name != project.title
            let isValidTheme = theme != project.theme
            return isValidName || isValidTheme
        }
    }

    func commit(values: ProjectFormFieldValues) throws {
        switch self.mode {
        case .create:
            try self.createProject(with: values)
        case .update(let project):
            self.updateProject(project, values: values)
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

    func createProject(with values: ProjectFormFieldValues) throws {
        let project = Project(
            id: UUID(),
            title: values.name.trimmingCharacters(in: .whitespacesAndNewlines),
            theme: values.theme.trimmingCharacters(in: .whitespacesAndNewlines),
            contents: [],
            creationDate: .now,
            lastUpdatedDate: .now
        )

        do {
            try self.dataStore.create(model: project)
            self.notificationCenter.post(name: .didCreateProject, object: nil)
        } catch {
            throw ProjectFormViewModelError.create(error)
        }
    }

    func updateProject(_ project: Project, values: ProjectFormFieldValues) {
        project.title = values.name.trimmingCharacters(in: .whitespacesAndNewlines)
        project.theme = values.theme.trimmingCharacters(in: .whitespacesAndNewlines)
        project.lastUpdatedDate = .now
        self.notificationCenter.post(name: .didUpdateProject, object: nil)
    }
}
