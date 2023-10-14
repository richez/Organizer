//
//  AppStorage+Key.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

extension AppStorage {
    init(
        wrappedValue: Value,
        _ key: StorageKey,
        store: UserDefaults? = nil
    ) where Value : RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }

    init(
        wrappedValue: Value,
        _ key: StorageKey,
        store: UserDefaults? = nil
    ) where Value == Bool {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }

    mutating func update(
        with store: UserDefaults?,
        key: StorageKey
    ) where Value : RawRepresentable, Value.RawValue == String {
        self = AppStorage(wrappedValue: self.wrappedValue, key, store: store)
    }

    mutating func update(
        with store: UserDefaults?,
        key: StorageKey
    ) where Value == Bool {
        self = AppStorage(wrappedValue: self.wrappedValue, key, store: store)
    }
}
