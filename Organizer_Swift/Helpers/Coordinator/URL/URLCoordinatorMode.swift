//
//  URLCoordinatorMode.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

enum URLCoordinatorMode {
    /// Open the provided `URL` in a `SafariViewController`.
    case inApp(URL)

    /// Open the provided `URL` in the browser (`UIApplication.open`).
    case external(URL)
}
