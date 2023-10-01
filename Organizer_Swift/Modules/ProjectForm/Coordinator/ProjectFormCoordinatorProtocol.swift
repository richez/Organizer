//
//  ProjectFormCoordinatorProtocol.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

protocol ProjectFormCoordinatorProtocol: AnyObject {
    /// Presents an `UIAlertController` configurated with the specified `Error`.
    func show(error: Error)

    func finish()
}
