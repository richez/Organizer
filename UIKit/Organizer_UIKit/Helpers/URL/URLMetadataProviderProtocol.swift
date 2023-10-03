//
//  URLMetadataProviderProtocol.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 02/10/2023.
//

import Foundation

/// A type representing an object that can retrieve link metadata.
protocol URLMetadataProviderProtocol {
    /// Fetches the title metadata for the given URL representation or throw a
    /// ``URLMetadataProviderError`` error.
    func title(of urlRepresentation: String) async throws -> String
}
