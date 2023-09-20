//
//  PasteboardManager.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 20/09/2023.
//

import UIKit

protocol PasteboardManagerProtocol {
    func copy(url: URL?)
}

struct PasteboardManager {
    // MARK: - Properties

    var pasteboard: UIPasteboard = .general
}

// MARK: - PasteboardManagerProtocol

extension PasteboardManager: PasteboardManagerProtocol {
    func copy(url: URL?) {
        self.pasteboard.url = url
    }
}
