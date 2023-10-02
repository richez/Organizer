//
//  AnyOptional.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 14/09/2023.
//

import Foundation

/// A type meant to be used by the storage property wrappers
/// in order to identify `nil` values to remove them from the
/// `UserDefaults`
///
/// The associated type of the ``Storage`` and ``RawRepresentableStorage``
/// property wrappers is not optional but can contain nil values. Thus,
/// this protocol is used to enable us to cast any assigned value into a type
/// that we can compare against `nil` to remove them from the storage.
///  Otherwise setting a nil value would crash
protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}
