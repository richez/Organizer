//
//  AppStorage+Key.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

extension AppStorage {
    // MARK: Optional RawRepresentable

    init<R>(
        _ key: StorageKey,
        store: UserDefaults? = nil
    ) where Value == R?, R : RawRepresentable, R.RawValue == String {
        self.init(key.rawValue, store: store)
    }

    mutating func update<R>(
        with store: UserDefaults?,
        key: StorageKey
    ) where Value == R?, R : RawRepresentable, R.RawValue == String {
        self = AppStorage(key, store: store)
    }

    // MARK: - RawRepresentable

    init(
        wrappedValue: Value,
        _ key: StorageKey,
        store: UserDefaults? = nil
    ) where Value : RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }

    mutating func update(
        with store: UserDefaults?,
        key: StorageKey
    ) where Value : RawRepresentable, Value.RawValue == String {
        self = AppStorage(wrappedValue: self.wrappedValue, key, store: store)
    }

    // MARK: - Optional String

    init(
        wrappedValue: Value,
        _ key: StorageKey,
        store: UserDefaults? = nil
    ) where Value == String? {
        self.init(key.rawValue, store: store)
    }

    mutating func update(
        with store: UserDefaults?,
        key: StorageKey
    ) where Value == String? {
        self = AppStorage(wrappedValue: self.wrappedValue, key, store: store)
    }

    // MARK: - Bool

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
    ) where Value == Bool {
        self = AppStorage(wrappedValue: self.wrappedValue, key, store: store)
    }
}
