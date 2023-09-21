//
//  ShareView.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import UIKit

final class ShareView: UIView {
    // MARK: - Properties

    private let contentFormView: ContentFormView = .init()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with configuration: ContentFormViewConfiguration) {
        self.contentFormView.configure(with: configuration)
    }
}

private extension ShareView {

    // MARK: - Setup

    func setup() {
        self.setupContentFormView()
    }

    func setupContentFormView() {
        self.addSubview(self.contentFormView)
        self.contentFormView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentFormView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentFormView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentFormView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentFormView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
