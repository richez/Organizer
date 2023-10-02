//
//  ContentFormFieldsConfiguration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import Foundation

/// Define the properties used to configure the ``ContentFormFieldsView``
struct ContentFormFieldsConfiguration {
    var type: ContentFormMenu
    var link: ContentFormField
    var linkError: ContentFormError
    var name: ContentFormField
    var nameGetter: ContentFormButton
    var theme: ContentFormField
}
