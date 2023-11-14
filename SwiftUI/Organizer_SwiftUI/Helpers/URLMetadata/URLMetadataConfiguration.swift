//
//  URLMetadataConfiguration.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 16/10/2023.
//

import Foundation

struct URLMetadataConfiguration {
    /// A Boolean value indicating whether to download subresources (con, image, or video) specified
    /// by the metadata.  Equivalent to `LPMetadataProvider.shouldFetchSubresources` property.
    var shouldFetchSubresources: Bool = false

    /// The time interval after which the request automatically fails if it hasn’t already completed.
    /// Equivalent to `LPMetadataProvider.timeout` property.
    var timeout: TimeInterval = 20
}
