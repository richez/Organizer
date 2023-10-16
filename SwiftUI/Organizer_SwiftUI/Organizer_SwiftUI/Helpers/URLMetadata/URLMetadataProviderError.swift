//
//  URLMetadataProviderError.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 16/10/2023.
//

import Foundation

enum URLMetadataProviderError: Error {
    case badURL(String)
    case fetch(Error?)
}
