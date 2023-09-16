//
//  UserRepository+Key.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 13/09/2023.
//

import Foundation

enum StorageKey: String {
    // MARK: - Project List

    case projectListAscendingOrder
    case projectListSorting
    case projectListShowTheme
    case projectListShowStatistics
    case projectListSelectedTheme

    // MARK: - Project Content List

    case projectContentListAscendingOrder
    case projectContentListSorting
    case projectContentListShowTheme
    case projectContentListShowType
    case projectContentListSelectedTheme
    case projectContentListSelectedType
}
