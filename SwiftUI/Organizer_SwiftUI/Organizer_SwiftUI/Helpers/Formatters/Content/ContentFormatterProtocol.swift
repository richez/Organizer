//
//  ContentFormatterProtocol.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation

protocol ContentFormatterProtocol {
    func content(from values: ContentValues) -> ProjectContent
    func values(type: ProjectContentType, url: URL, title: String, theme: String) -> ContentValues
    func themes(from contents: [ProjectContent]) -> [String]
    func themes(from string: String) -> String
    func filtersDescription(from selectedTheme: String?, selectedType: ProjectContentType?) -> String
}
