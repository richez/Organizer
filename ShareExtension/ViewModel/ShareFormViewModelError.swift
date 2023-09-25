//
//  ShareFormViewModelError.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 25/09/2023.
//

import Foundation

enum ShareFormViewModelError: Error {
    case urlMissing
    case urlLoading(Error?)
}
