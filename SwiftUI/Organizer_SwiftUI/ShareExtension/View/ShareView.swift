//
//  ShareView.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import UIKit

final class ShareView: UIView {
    // MARK: - Properties

    private let activityIndicatorView: UIActivityIndicatorView = .init()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Loader

    func startLoader() {
        self.activityIndicatorView.startAnimating()
    }

    func stopLoader() {
        self.activityIndicatorView.stopAnimating()
    }
}

private extension ShareView {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = .listBackground

        self.setupActivityIndicator()
    }

    func setupActivityIndicator() {
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.color = .floatingButton
        self.activityIndicatorView.style = .large

        self.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
