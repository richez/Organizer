//
//  ProjectCreatorViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

final class ProjectCreatorViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView = ProjectCreatorView()

    private let viewModel: ProjectCreatorViewModel

    // MARK: - Initialization

    init(viewModel: ProjectCreatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        self.view = self.contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
