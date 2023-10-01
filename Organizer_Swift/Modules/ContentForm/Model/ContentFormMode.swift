//
//  ContentFormMode.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

/// The mode that defined how the content form should be configured.
enum ContentFormMode {
    /// Display empty fields
    case create

    /// The fields are pre filled with the specified ``ProjectContent`` data.
    case update(ProjectContent)
}
