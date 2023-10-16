//
//  URLMetadataProvider.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 16/10/2023.
//

import Foundation
import LinkPresentation

/// A type that conform to ``URLMetadataProviderProtocol`` and use the `LinkPresentation`
/// module to fetch link metadata (`LPMetadataProvider.startFetchingMetadata(for:)`)
struct URLMetadataProvider {
    let configuration: URLMetadataConfiguration = .init()
}

// MARK: - URLMetadataProviderProtocol

extension URLMetadataProvider: URLMetadataProviderProtocol {
    func title(of urlRepresentation: String) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            guard urlRepresentation.isValidURL(), let url = URL(string: urlRepresentation) else {
                return continuation.resume(throwing: URLMetadataProviderError.badURL(urlRepresentation))
            }

            let provider = LPMetadataProvider()
            provider.shouldFetchSubresources = self.configuration.shouldFetchSubresources
            provider.timeout = self.configuration.timeout
            provider.startFetchingMetadata(for: url) { metadata, error in
                if let title = metadata?.title {
                    continuation.resume(returning: title)
                } else {
                    continuation.resume(throwing: URLMetadataProviderError.fetch(error))
                }
            }
        }
    }
}
