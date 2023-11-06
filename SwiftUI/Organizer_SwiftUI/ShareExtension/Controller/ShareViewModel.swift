//
//  ShareViewModel.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import Foundation
import OSLog
import UniformTypeIdentifiers

struct ShareContent {
    var title: String
    var url: String
}

@MainActor
struct ShareViewModel {
    func loadContent(in extensionItem: NSExtensionItem?) async -> ShareContent {
        let title = extensionItem?.attributedTitle?.string ?? extensionItem?.attributedContentText?.string ?? ""
        let url = await self.url(in: extensionItem?.attachments)
        Logger.forms.info("Title \(title) and url \(url) retrieved from extension context")
        return .init(title: title, url: url)
    }
}

private extension ShareViewModel {
    func url(in attachments: [NSItemProvider]?) async -> String {
        return await withCheckedContinuation { continuation in
            guard
                let urlAttachment = attachments?.first(where: { $0.hasItemConformingToTypeIdentifier(UTType.url.identifier) })
            else {
                return continuation.resume(returning: "")
            }

            urlAttachment.loadItem(forTypeIdentifier: UTType.url.identifier) { result, error in
                if let url = result as? URL {
                    continuation.resume(returning: url.absoluteString)
                } else {
                    return continuation.resume(returning: "")
                }
            }
        }
    }
}
