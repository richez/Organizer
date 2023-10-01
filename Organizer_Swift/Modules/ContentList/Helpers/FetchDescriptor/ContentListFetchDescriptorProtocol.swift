//
//  ContentListFetchDescriptorProtocol.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

protocol ContentListFetchDescriptorProtocol {
    /// The predicate to selectively fetch content from the persistent stores according to
    /// the values of ``ContentListSettings``
    var predicate: Predicate<ProjectContent>? { get }

    /// The sort descriptors used to define how the project list should be sorted according to
    /// the values of ``ContentListSettings``
    var sortDescriptor: [SortDescriptor<ProjectContent>] { get }
}
