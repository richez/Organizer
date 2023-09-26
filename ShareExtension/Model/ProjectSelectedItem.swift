//
//  ProjectSelectedItem.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 25/09/2023.
//

import Foundation
import SwiftData

enum ProjectSelectedItem {
    case new(String)
    case custom(PersistentIdentifier)
}
