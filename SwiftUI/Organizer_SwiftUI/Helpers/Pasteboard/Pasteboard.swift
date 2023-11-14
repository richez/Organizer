//
//  Pasteboard.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 20/10/2023.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

struct Pasteboard {
    static let general = Pasteboard()

    func set(_ url: URL) {
        #if os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(url.absoluteString, forType: .URL)
        #else
        UIPasteboard.general.url = url
        #endif
    }
}
