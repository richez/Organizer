//
//  URLMetadataProvider.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 20/10/2023.
//

import Foundation

// Feature not implemented on macOS
struct URLMetadataProvider: URLMetadataProviderProtocol {
    func title(of urlRepresentation: String) async throws -> String {
        return ""
    }
}
