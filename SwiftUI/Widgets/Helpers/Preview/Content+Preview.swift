//
//  Content+Preview.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 05/11/2023.
//

import Foundation

extension ProjectContent {
    static var preview: ProjectContent = .init(
        type: .article,
        title: "How to build stairs ?",
        theme: "stairs",
        url: URL(string: "https://www.youtube.com")!
    )
}
