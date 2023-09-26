//
//  ProjectsCellData.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation
import SwiftData

struct ProjectDescription: Hashable {
    var id: PersistentIdentifier
    var title: String
    var theme: String?
    var statistics: String?
    var lastUpdatedDate: String
}
