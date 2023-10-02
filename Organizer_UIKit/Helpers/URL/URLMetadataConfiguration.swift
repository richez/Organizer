//
//  URLMetadataConfiguration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 27/09/2023.
//

import Foundation

struct URLMetadataConfiguration {
    /// A Boolean value indicating whether to download subresources (con, image, or video) specified
    /// by the metadata.  Equivalent to `LPMetadataProvider.shouldFetchSubresources` property.
    var shouldFetchSubresources: Bool

    /// The time interval after which the request automatically fails if it hasn’t already completed.
    /// Equivalent to `LPMetadataProvider.timeout` property.
    var timeout: TimeInterval
}
