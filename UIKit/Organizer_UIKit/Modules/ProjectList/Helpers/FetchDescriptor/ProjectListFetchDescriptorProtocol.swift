//
//  ProjectListFetchDescriptorProtocol.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

protocol ProjectListFetchDescriptorProtocol {
    /// The predicate to selectively fetch projects from the persistent stores according to
    /// the values of ``ProjectListSettings``
    var predicate: Predicate<Project>? { get }

    /// The sort descriptors used to define how the project list should be sorted according to
    /// the values of ``ProjectListSettings``
    var sortDescriptor: [SortDescriptor<Project>] { get }
}
