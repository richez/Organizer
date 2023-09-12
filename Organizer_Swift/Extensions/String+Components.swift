//
//  String+Components.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 13/09/2023.
//

import Foundation

extension String {
    /// A collection of all the words in the string by separating out any punctuation and spaces.
    var words: [String] {
        self.components(separatedBy: .alphanumerics.inverted).filter { !$0.isEmpty }
    }
}
