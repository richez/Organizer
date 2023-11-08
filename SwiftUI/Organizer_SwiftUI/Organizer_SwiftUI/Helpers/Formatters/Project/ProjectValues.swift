//
//  ProjectValues.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 24/10/2023.
//

import Foundation

struct ProjectValues {
    var title: String
    var theme: String = ""
}

extension ProjectValues: CustomStringConvertible {
    var description: String {
        "title '\(self.title)', themes '\(self.theme.words)'"
    }
}
