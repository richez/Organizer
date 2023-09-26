//
//  ProjectListSettings.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 14/09/2023.
//

import Foundation

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

    func delete(suiteName: String) {
        UserDefaults.standard.removePersistentDomain(forName: suiteName)
    }
}
