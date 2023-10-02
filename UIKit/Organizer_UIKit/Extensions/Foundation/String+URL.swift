//
//  String+URL.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 29/09/2023.
//

import Foundation
import RegexBuilder

extension String {
    /// Returns `true` if the whole associated string starts with 'http(s)://'
    /// and is followed by one or more allowed characters.
    func isValidURL() -> Bool {
        let regex = Regex {
            "http"
            Optionally {
                "s"
            }
            "://"
            OneOrMore(.word)
            "."
            OneOrMore(.whitespace.inverted)
        }
        return self.wholeMatch(of: regex) != nil
    }
}
