//
//  WidgetManager.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 09/11/2023.
//

import Combine
import Foundation
import OSLog
import WidgetKit

/// An object responsible of requesting widget timelines reload by observing 
/// the notifications posted by ``StoreNotificationCenter``.
final class WidgetManager {
    // MARK: - Properties

    private let notificationCenter: NotificationCenter
    private let widgetCenter: WidgetCenter
    private var subscriptions: Set<AnyCancellable> = .init()

    // MARK: - Initialization

    init(center: NotificationCenter = .default, widgetCenter: WidgetCenter = .shared) {
        self.notificationCenter = center
        self.widgetCenter = widgetCenter
    }

    // MARK: - Public

    func observeStoreNotifications() {
        Logger.widgets.info("Start observing store notifications to update widgets when needed")

        self.observeNotifications([
            .didCreateProject,
            .didDeleteProject,
            .willUpdateProject,
            .didUpdateProjectContent
        ])
    }
}

// MARK: - Notifications

private extension WidgetManager {
    func observeNotifications(_ names: [Notification.Name]) {
        names.forEach { name in
            self.notificationCenter
                .publisher(for: name)
                .compactMap(self.projectData(from:))
                .sink(receiveValue: self.updateWidgets(with:))
                .store(in: &self.subscriptions)
        }
    }
}

// MARK: - Project Data

private extension WidgetManager {
    /// Defines the properties received in the notification
    /// user-info dictionnary.
    struct ProjectData {
        var identifier: UUID
        var oldValues: ProjectValues?
        var newValues: ProjectValues?
    }

    func projectData(from notification: Notification) -> ProjectData? {
        guard 
            let userInfo = notification.userInfo,
            let projectID = userInfo[StoreNotificationCenter.UserInfoKey.projectID] as? UUID
        else {
            Logger.widgets.info("Received \(notification) with invalid user info")
            return nil
        }

        let oldValues = userInfo[StoreNotificationCenter.UserInfoKey.oldValues] as? ProjectValues
        let newValues = userInfo[StoreNotificationCenter.UserInfoKey.newValues] as? ProjectValues
        Logger.widgets.info("Received \(notification) with valid user info")
        return ProjectData(identifier: projectID, oldValues: oldValues, newValues: newValues)
    }
}

// MARK: - Widgets

private extension WidgetManager {
    func updateWidgets(with project: ProjectData) {
        Task {
            let widgets = await self.installedWidgets()
            Logger.widgets.info("Found installed widgets: \(widgets)")

            let needsUpdate = widgets.filter { self.needsUpdate($0, project: project) }
            needsUpdate.forEach { self.widgetCenter.reloadTimelines(ofKind: $0.kind.rawValue) }
            Logger.widgets.info("Reload timelines for widgets: \(needsUpdate)")
        }
    }

    /// Returns the widgets installed in the user's device with their configurations
    /// to determine if they need to be reloaded after a change occured in the databse.
    func installedWidgets() async -> [InstalledWidget] {
        do {
            let widgets = try await self.widgetCenter.getCurrentConfigurations()
            return widgets.compactMap(self.installedWidgets(from:))
        } catch {
            Logger.widgets.info("Fail to retrieve widget configurations: \(error)")
            return []
        }
    }

    func installedWidgets(from widget: WidgetInfo) -> InstalledWidget? {
        guard let kind = WidgetKind(rawValue: widget.kind) else { return nil }

        switch kind {
        case .lastProject:
            return .lastProject
        case .projects:
            let theme = self.projectsIntentTheme(from: widget)
            return .projects(theme: theme)
        case .singleProject:
            let projectID = self.singleProjectIntentIdentifier(from: widget)
            return .singleProject(projectID)
        default:
            return nil
        }
    }

    /// Returns `true` if the provided widget needs to be updated after the change described
    /// by ``WidgetManager/ProjectData`` occured in the database.
    ///
    /// - The ``WidgetKind/addProject`` widget never needs to be updated since it display static data.
    /// - The ``WidgetKind/lastProject`` widget needs to be updated every time a change occurs in the
    /// database since it will always change which is the last edited project.
    /// - The ``WidgetKind/projects`` widget needs to be updated every time a change occurs if the user
    /// did not configured the associated theme since the last edited project is used. Otherwise, it
    /// needs to be updated only if the change concerns a project that had or added the selected theme.
    /// - The ``WidgetKind/singleProject`` widget needs to be updated every time a change occurs if the user
    /// did not configured the associated project since the last edited project is used. Otherwise, it
    /// needs to be updated only if the change concerns the configured project.
    func needsUpdate(_ installedWidget: InstalledWidget, project: ProjectData) -> Bool {
        switch installedWidget {
        case .lastProject:
            return true
        case .projects(let theme):
            guard let theme else { return true }
            let projectThemes = [project.oldValues, project.newValues].compactMap(\.?.theme)
            return projectThemes.contains(theme)
        case .singleProject(let identifier):
            guard let identifier else { return true }
            return identifier == project.identifier
        }
    }

    enum InstalledWidget {
        case lastProject
        case projects(theme: String?)
        case singleProject(UUID?)

        var kind: WidgetKind {
            switch self {
            case .lastProject: .lastProject
            case .projects: .projects
            case .singleProject: .singleProject
            }
        }
    }
}
