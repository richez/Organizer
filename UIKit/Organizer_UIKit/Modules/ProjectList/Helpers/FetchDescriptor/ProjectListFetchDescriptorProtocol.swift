//
//  ProjectListFetchDescriptorProtocol.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

protocol ProjectListFetchDescriptorProtocol {
    /// The predicate to selectively fetch projects from the persistent stores.
    var predicate: Predicate<Project>? { get }

    /// The sort descriptors that define how the projects should be sorted.
    var sortDescriptors: [SortDescriptor<Project>] { get }
}
