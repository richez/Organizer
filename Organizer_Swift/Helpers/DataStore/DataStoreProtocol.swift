//
//  DataStoreReader.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation
import SwiftData

protocol DataStoreReader {
    /// Returns an array of objects from the persistent stores that meet the criteria of the
    /// specified predicate and sort descriptor.
    func fetch<T: PersistentModel>(predicate: Predicate<T>?, sortBy: [SortDescriptor<T>]) throws -> [T]

    /// Returns the number of objects in the persistent stores that meet the criteria of the
    /// specified predicate.
    func fetchCount<T: PersistentModel>(predicate: Predicate<T>?) throws -> Int

    /// Returns the object from the persistent stores associated with the specified identifier.
    func model<T: PersistentModel>(with identifier: PersistentIdentifier) throws -> T
}

protocol DataStoreCreator {
    /// Inserts an object in the context’s persistent store.
    func create(model: any PersistentModel) throws
}

protocol DataStoreDeleter {
    /// Deletes an object in the context’s persistent store.
    func delete(model: any PersistentModel) throws
}

protocol DataStoreProtocol: DataStoreReader & DataStoreCreator & DataStoreDeleter {}
