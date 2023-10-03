//
//  ContentListFetchDescriptorProtocol.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

protocol ContentListFetchDescriptorProtocol {
    /// The predicate to selectively fetch contents from the persistent stores.
    var predicate: Predicate<ProjectContent>? { get }

    /// The sort descriptors that define how the contents should be sorted.
    var sortDescriptors: [SortDescriptor<ProjectContent>] { get }
}
