//
//  ProjectFormatterProtocol.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import Foundation

protocol ProjectFormatterProtocol {
    func project(from values: ProjectValues) -> Project
    func values(title: String, theme: String) -> ProjectValues
    func themes(from projects: [Project]) -> [String]
    func themes(from string: String) -> String
    func filterDescription(from selectedTheme: String?) -> String
    func statistics(from contents: [ProjectContent]) -> String
    func string(from date: Date, format: ProjectFormatter.DateFormat) -> String
}
