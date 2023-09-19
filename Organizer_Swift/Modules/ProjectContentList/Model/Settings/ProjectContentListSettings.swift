//
//  ProjectContentListSettings.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 16/09/2023.
//

import Foundation

struct ProjectContentListSettings {
    @Storage(key: .projectContentListAscendingOrder, default: true)
    var ascendingOrder: Bool

    @RawRepresentableStorage(key: .projectContentListSorting, default: .lastUpdated)
    var sorting: ProjectContentListSorting

    @Storage(key: .projectContentListShowTheme, default: true)
    var showTheme: Bool

    @Storage(key: .projectContentListShowType, default: true)
    var showType: Bool

    @RawRepresentableStorage(key: .projectContentListSelectedTheme, default: .all)
    var selectedTheme: ProjectListSelectedTheme

    @RawRepresentableStorage(key: .projectContentListSelectedType, default: .all)
    var selectedType: ProjectListSelectedType
}
