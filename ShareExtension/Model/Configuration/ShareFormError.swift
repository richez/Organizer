//
//  ShareFormError.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 27/09/2023.
//

import Foundation

struct ShareFormError {
    var text: String?

    var isHidden: Bool { self.text == nil }
}
