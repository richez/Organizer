//
//  ContentFormCoordinatorProtocol.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 02/10/2023.
//

import Foundation

protocol ContentFormCoordinatorProtocol: AnyObject {
    /// Presents an `UIAlertController` configurated with the specified `Error`.
    func show(error: Error)

    func finish()
}
