//
//  ContentListSorting.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation

enum ContentListSorting: String, Identifiable, CaseIterable {
    case updatedDate = "Modification Date"
    case createdDate = "Creation Date"
    case title = "Title"
    case type = "Type"

    var id: ContentListSorting { self }
}
