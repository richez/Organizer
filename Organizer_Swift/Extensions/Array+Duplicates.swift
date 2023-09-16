//
//  Array+Duplicates.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 16/09/2023.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var dictionary = [Element: Bool]()
        // updateValue returns nil only for new keys
        return self.filter { dictionary.updateValue(true, forKey: $0) == nil }
    }
}
