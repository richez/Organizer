//
//  ContentFormButton.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 27/09/2023.
//

import Foundation

struct ContentFormButton {
    var text: String?
    var isEnabled: Bool

    var isHidden: Bool { self.text == nil }
}
