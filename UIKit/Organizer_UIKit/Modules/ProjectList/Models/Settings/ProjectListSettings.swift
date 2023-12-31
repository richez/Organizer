//
//  ProjectListSettings.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 14/09/2023.
//

import Foundation

/// Defines the settings (`UserDefaults`) that are used to define
/// how and what data the project list shoud display.
final class ProjectListSettings {
    @Storage(key: .projectListAscendingOrder, default: true)
    var ascendingOrder: Bool

    @RawRepresentableStorage(key: .projectListSorting, default: .lastUpdated)
    var sorting: ProjectListSorting

    @Storage(key: .projectListShowTheme, default: true)
    var showTheme: Bool

    @Storage(key: .projectListShowStatistics, default: true)
    var showStatistics: Bool

    @RawRepresentableStorage(key: .projectListSelectedTheme, default: .all)
    var selectedTheme: ProjectListSelectedTheme

    var group: AppGroupSettings = .init()

    /// Deletes the settings associated to the current project.
    func delete(suiteName: String) {
        UserDefaults.standard.removePersistentDomain(forName: suiteName)
    }
}
