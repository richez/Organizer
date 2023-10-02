//
//  URLMetadataProviderError.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 27/09/2023.
//

import Foundation

enum URLMetadataProviderError: Error {
    case badURL(String)
    case fetch(Error?)
}
