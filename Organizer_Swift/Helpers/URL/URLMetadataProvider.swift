//
//  URLMetadataProvider.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 27/09/2023.
//

import Foundation
import LinkPresentation

protocol URLMetadataProviderProtocol {
    func title(for urlRepresentation: String) async throws -> String
}

struct URLMetadataProvider {
    var configuration: URLMetadataConfiguration
}

// MARK: - URLMetadataProviderProtocol

extension URLMetadataProvider: URLMetadataProviderProtocol {
    func title(for urlRepresentation: String) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            guard let url = URL(string: urlRepresentation) else {
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
