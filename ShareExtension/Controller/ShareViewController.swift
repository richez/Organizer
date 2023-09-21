//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import UIKit

final class ShareViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView: ShareView = .init()

    private let viewModel: ShareViewModel = .init()

    // MARK: - Life Cycle

    override func loadView() {
        self.view = self.contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
}


private extension ShareViewController {
    // MARK: - Setup

    func setup() {
        self.contentView.configure(with: self.viewModel.viewConfiguration)
    }
}
