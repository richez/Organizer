//
//  DataStoreError.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation
import SwiftData

enum DataStoreError: Error {
    case databaseUnreachable
    case notFound(PersistentIdentifier)
}
