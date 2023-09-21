//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import UIKit

final class ShareViewController: UIViewController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
}


private extension ShareViewController {
    // MARK: - Setup

    func setup() {
        self.view.backgroundColor = .red
    }
}
