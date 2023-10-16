//
//  URL+Identifiable.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 16/10/2023.
//

import Foundation

extension URL: Identifiable {
    public var id: String { self.absoluteString }
}
