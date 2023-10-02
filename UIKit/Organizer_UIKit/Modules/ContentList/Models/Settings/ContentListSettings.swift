//
//  ContentListSettings.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 16/09/2023.
//

import Foundation

/// Defines the settings (`UserDefaults`) that are used to define
/// how and what data the content list shoud display for a given project.
final class ContentListSettings {
    @Storage(key: .contentListAscendingOrder, default: true)
    var ascendingOrder: Bool

    @RawRepresentableStorage(key: .contentListSorting, default: .lastUpdated)
    var sorting: ContentListSorting

    @Storage(key: .contentListShowTheme, default: true)
    var showTheme: Bool

    @Storage(key: .contentListShowType, default: true)
    var showType: Bool

    @RawRepresentableStorage(key: .contentListSelectedTheme, default: .all)
    var selectedTheme: ContentListSelectedTheme

    @RawRepresentableStorage(key: .contentListSelectedType, default: .all)
    var selectedType: ContentListSelectedType

    /// - Parameter suiteName: A string used to uniquely identify a project in order
    /// to have custom settings for each project (``Project/id``)
    ///
    /// The associated container values will be deleted from storage on project deletion
    /// (``ProjectListViewModel/deleteProject(with:)``)
    init(suiteName: String) {
        let container: UserDefaults = .init(suiteName: suiteName) ?? .standard
        self._ascendingOrder.container = container
        self._sorting.container = container
        self._showTheme.container = container
        self._showType.container = container
        self._selectedTheme.container = container
        self._selectedType.container = container
    }
}
