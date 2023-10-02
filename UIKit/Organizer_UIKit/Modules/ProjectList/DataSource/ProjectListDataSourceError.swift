//
//  ProjectListDataSourceError.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

enum ProjectListDataSourceError: Error {
    case notFound(IndexPath)
}
