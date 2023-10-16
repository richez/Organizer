//
//  SafariView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 16/10/2023.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> some UIViewController {
        let safariViewController = SFSafariViewController(url: self.url)
        safariViewController.dismissButtonStyle = .close
        safariViewController.preferredBarTintColor = .listBackground
        return safariViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
