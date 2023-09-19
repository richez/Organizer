//
//  ContentListSettings.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 16/09/2023.
//

import Foundation

// TODO: add storage specific container to each project to save specific settings
// TODO: delete the container when project is deleted
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
}
