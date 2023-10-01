//
//  UserDefaults+AppGroup.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

extension UserDefaults {
    static var appGroup: UserDefaults? { .init(suiteName: "group.thibautrichez.organizer.container") }
}
