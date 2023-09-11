//
//  ProjectContentViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

final class ProjectContentViewController: UIViewController {
    private lazy var contentView = ProjectContentView()

    private unowned let coordinator: ProjectContentCoordinatorProtocol
    private let viewModel: ProjectContentViewModel

    // MARK: - Initialization

    init(viewModel: ProjectContentViewModel, coordinator: ProjectContentCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
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

        self.setup()
    }
}

private extension ProjectContentViewController {
    func setup() {
        self.contentView.delegate = self
        
        self.title = self.viewModel.navigationBarTitle
        self.navigationController?.navigationBar.applyAppearance()
    }
}

extension ProjectContentViewController: ProjectContentViewDelegate {
    func didSelectContent(at indexPath: IndexPath) {
    }
    
    func didTapContentCreatorButton() {
    }
}
