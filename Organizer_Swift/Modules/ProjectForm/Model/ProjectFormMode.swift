//
//  ProjectFormMode.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 18/09/2023.
//

import Foundation

/// The mode that defined how the form should be configured.
enum ProjectFormMode {
    /// Display empty fields
    case create

    /// The fields are pre filled with the specified ``Project`` data.
    case update(Project)
}
