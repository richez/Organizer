//
//  ViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class ProjectsViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView = ProjectsView()

    private let viewModel: ProjectsViewModel
    private lazy var dataSource = ProjectsTableViewDataSource(tableView: self.contentView.tableView)

    // MARK: - Initialization

    init(viewModel: ProjectsViewModel) {
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

        self.setup()
        self.configure()
    }
}

private extension ProjectsViewController {
    // MARK: - Setup

    func setup() {
        self.title = self.viewModel.navigationBarTitle
        self.navigationController?.navigationBar.applyAppearance()
    }

    // MARK: - Configuration

    func configure() {
        self.dataSource.applySnapshot(
            section: self.viewModel.projectsSection,
            projects: self.viewModel.projectsData,
            animated: false
        )
    }
}
