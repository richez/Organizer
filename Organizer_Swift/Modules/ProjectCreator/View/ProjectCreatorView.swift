//
//  ProjectCreatorView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

final class ProjectCreatorView: UIView {
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProjectCreatorView {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = .red
    }
}
