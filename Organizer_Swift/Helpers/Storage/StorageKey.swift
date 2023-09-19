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

    // MARK: - Content List

    case contentListAscendingOrder
    case contentListSorting
    case contentListShowTheme
    case contentListShowType
    case contentListSelectedTheme
    case contentListSelectedType
}
