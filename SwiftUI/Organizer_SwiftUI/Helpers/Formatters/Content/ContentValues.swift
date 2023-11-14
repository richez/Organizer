//
//  ContentValues.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 24/10/2023.
//

import Foundation

struct ContentValues {
    var type: ProjectContentType
    var url: URL
    var title: String
    var theme: String
}

extension ContentValues: CustomStringConvertible {
    var description: String {
        """
       title '\(self.title)', \
       themes '\(self.theme.words)', \
       type \(self.type), \
       url '\(self.url)'
       """
    }
}
