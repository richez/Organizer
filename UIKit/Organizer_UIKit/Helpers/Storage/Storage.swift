//
//  Storage.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 13/09/2023.
//

import Foundation

/// A `propertyWrapper` that allows to define values that are backed by `UserDefaults`.
///
/// - Note: `self` cannot be referenced when initializing a `propertyWrapper`. Thus, the
/// `container` property must be set after when not using `UserDefaults.standard`.
/// ```
///     struct Object {
///         /// @Storage(..., container: self.defaults) -> Cannot find 'self' in scope
///         @Storage(key: .testing, defaultValue: false)
///         var isTesting: Bool
///
///         private let defaults: UserDefaults
///
///         init(defaults: UserDefaults) {
///             self.defaults = defaults
///             self._isTesting.container = defaults
///         }
/// ```
/// Follow-up: Allowing the reference of `self` is under discussion in the Swift evolution
/// proposals: https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md#referencing-the-enclosing-self-in-a-wrapper-type
@propertyWrapper
struct Storage<Value> {
    let key: StorageKey
    let defaultValue: () -> Value
    var container: UserDefaults

    var projectedValue: Storage<Value> { self }

    init(key: StorageKey, default defaultValue: @escaping @autoclosure () -> Value, container: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
    }

    var wrappedValue: Value {
        get {
            return self.container.object(forKey: self.key.rawValue) as? Value ?? self.defaultValue()
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                self.container.removeObject(forKey: self.key.rawValue)
            } else {
                self.container.set(newValue, forKey: self.key.rawValue)
            }
        }
    }
}

extension Storage where Value: ExpressibleByNilLiteral {
    init(key: StorageKey, container: UserDefaults = .standard) {
        self.init(key: key, default: nil, container: container)
    }
}
