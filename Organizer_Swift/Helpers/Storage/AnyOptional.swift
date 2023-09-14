//
//  AnyOptional.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 14/09/2023.
//

import Foundation

protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}
