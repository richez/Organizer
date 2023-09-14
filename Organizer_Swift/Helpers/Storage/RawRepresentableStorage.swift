//
//  RawRepresentableStorage.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 13/09/2023.
//

import Foundation

@propertyWrapper
struct RawRepresentableStorage<Value: RawRepresentable> {
    let key: StorageKey
    let defaultValue: () -> Value
    let container: UserDefaults

    var projectedValue: RawRepresentableStorage<Value> { self }

    init(key: StorageKey, default defaultValue: @escaping @autoclosure () -> Value, container: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
    }

    var wrappedValue: Value {
        get {
            guard let rawValue = self.container.object(forKey: self.key.rawValue) as? Value.RawValue else {
                return self.defaultValue()
            }
            return Value(rawValue: rawValue) ?? self.defaultValue()
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                self.container.removeObject(forKey: self.key.rawValue)
            } else {
                self.container.set(newValue.rawValue, forKey: self.key.rawValue)
            }
        }
    }
}

extension RawRepresentableStorage where Value: ExpressibleByNilLiteral {
    init(key: StorageKey, container: UserDefaults = .standard) {
        self.init(key: key, default: nil, container: container)
    }
}
