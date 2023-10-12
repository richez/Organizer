//
//  String+Components.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation

extension String {
    /// A collection of all the words in the string separated by punctuations or spaces.
    var words: [String] {
        self.components(separatedBy: .alphanumerics.inverted).filter { !$0.isEmpty }
    }
}
