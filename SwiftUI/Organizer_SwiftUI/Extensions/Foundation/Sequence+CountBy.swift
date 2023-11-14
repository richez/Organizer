//
//  Sequence+CountBy.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 23/10/2023.
//

import Foundation

extension Sequence {
    /// Returns the number of elements filtered by the provided value.
    ///
    /// For example, you can use this method to build a dictionary of letter frequencies of a string.
    ///
    ///     let letters = "abracadabra"
    ///     let letterCount = letters.count(by: \.self)
    ///     // letterCount == ["a": 5, "b": 2, "r": 2, "c": 1, "d": 1]
    ///
    /// Or filter a custom object by one of its `Hashable` property
    ///
    ///     enum ContentType { case article, video }
    ///     struct Content {
    ///         var title: String
    ///         var type: ContentType
    ///     }
    ///     let contents = [Content(title: "Article", type: .article), Content(title: "Video", type: .video)]
    ///     let contentTypeCount = contents.count(by: \.type)
    ///     // contentTypeCount == [.article: 1, .video: 1]
    func count<T: Hashable>(by value: KeyPath<Element, T>) -> [T: Int] {
        self.reduce(into: [:]) { result, element in
            result[element[keyPath: value], default: 0] += 1
        }
    }
}
