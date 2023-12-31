//
//  ContentDescription.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import Foundation

/// Define the properties used to configure a ``ContentCell``
struct ContentDescription: Hashable {
    var id: UUID
    var typeImageName: String?
    var title: String
    var theme: String?
}
