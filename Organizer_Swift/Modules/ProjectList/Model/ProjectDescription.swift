//
//  ProjectsCellData.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

struct ProjectDescription: Hashable {
    var id: UUID
    var title: String
    var theme: String?
    var statistics: String?
    var lastUpdatedDate: String
}
