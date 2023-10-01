//
//  ProjectFormViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import Foundation

struct ProjectFormViewModel {
    // MARK: - Properties
    
    private let mode: ProjectFormMode
    private let dataStore: DataStoreCreator
    private let notificationCenter: NotificationCenter

    // MARK: - Initialization

    init(mode: ProjectFormMode, dataStore: DataStoreCreator, notificationCenter: NotificationCenter) {
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

    /// Returns `true` if specified field values are valid (i.e. a non empty name for the
    /// ``ProjectFormMode/create`` mode and a name or theme modification for
    /// ``ProjectFormMode/update(_:)`` mode), false otherwise.
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

    /// Creates or updates a ``Project`` with the specified values in the persistent stores
    /// according to the associated ``ProjectFormMode`` or throw a ``ProjectFormViewModelError/create(_:)``
    /// error if a ``Project`` could not be created.
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

    /// Creates a ``Project`` with the specified values in the persistent stores and post a
    /// `didCreateProject` notification or throw a ``ProjectFormViewModelError/create(_:)`` error.
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

    /// Updates the specified ``Project`` with new values in the persistent stores and post a
    /// `didUpdateProject` notification.
    func updateProject(_ project: Project, values: ProjectFormFieldValues) {
        project.title = values.name.trimmingCharacters(in: .whitespacesAndNewlines)
        project.theme = values.theme.trimmingCharacters(in: .whitespacesAndNewlines)
        project.lastUpdatedDate = .now
        self.notificationCenter.post(name: .didUpdateProject, object: nil)
    }
}
