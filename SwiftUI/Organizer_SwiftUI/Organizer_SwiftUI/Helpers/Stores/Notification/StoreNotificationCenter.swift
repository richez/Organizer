//
//  StoreNotificationCenter.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 09/11/2023.
//

import Foundation

struct StoreNotificationCenter {
    // MARK: - Properties

    var center: NotificationCenter = .default

    // MARK: Keys

    enum UserInfoKey: String {
        case projectID
        case oldValues
        case newValues
    }
}

// MARK: - StoreNotificationCenterProtocol

extension StoreNotificationCenter: StoreNotificationCenterProtocol {
    func post(_ notification: StoreNotification) {
        switch notification {
        case .created(let project):
            self.created(project)
        case .deleted(let project):
            self.deleted(project)
        case .willUpdate(let project, let newValues):
            self.willUpdate(project, with: newValues)
        case .didUpdateContent(let project):
            self.didUpdateContent(in: project)
        }
    }
}

// MARK: - Helpers

private extension StoreNotificationCenter {
    func created(_ project: Project) {
        self.center.post(
            name: .didCreateProject,
            object: nil,
            userInfo: [
                UserInfoKey.projectID: project.identifier
            ]
        )
    }

    func deleted(_ project: Project) {
        self.center.post(
            name: .didDeleteProject,
            object: nil,
            userInfo: [
                UserInfoKey.projectID: project.identifier
            ]
        )
    }

    func willUpdate(_ project: Project, with newValues: ProjectValues) {
        let oldValues = ProjectValues(title: project.title, theme: project.theme)
        self.center.post(
            name: .willUpdateProject,
            object: nil,
            userInfo: [
                UserInfoKey.projectID: project.identifier,
                UserInfoKey.oldValues: oldValues,
                UserInfoKey.newValues: newValues
            ]
        )
    }

    func didUpdateContent(in project: Project) {
        self.center.post(
            name: .didUpdateProjectContent,
            object: nil,
            userInfo: [
                UserInfoKey.projectID: project.identifier
            ]
        )
    }
}
