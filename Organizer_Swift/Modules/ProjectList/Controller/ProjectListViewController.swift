//
//  ProjectListViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class ProjectListViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView = ProjectListView()

    private let viewModel: ProjectListViewModel
    private unowned let coordinator: ProjectListCoordinatorProtocol

    private lazy var dataSource = ProjectListDataSource(tableView: self.contentView.tableView)

    // MARK: - Initialization

    init(viewModel: ProjectListViewModel, coordinator: ProjectListCoordinatorProtocol) {
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
        self.configure()
    }
}

private extension ProjectListViewController {
    // MARK: - Setup

    func setup() {
        self.dataSource.delegate = self
        self.contentView.delegate = self

        self.title = self.viewModel.navigationBarTitle
        self.navigationController?.navigationBar.applyAppearance()
    }

    // MARK: - Configuration

    func configure() {
        let projectDescriptions = self.viewModel.fetchProjectDescriptions()

        self.dataSource.applySnapshot(
            section: self.viewModel.section,
            projectDescriptions: projectDescriptions,
            animated: false
        )
    }
}

// MARK: - ProjectListDataSourceDelegate

extension ProjectListViewController: ProjectListDataSourceDelegate {
    func didTapDelete(on projectDescription: ProjectCellDescription) {
        do {
            try self.viewModel.deleteProject(id: projectDescription.id)
            self.dataSource.applySnapshot(deleting: projectDescription, animated: true)
        } catch {
            print("Fail to delete project: \(error)")
        }
    }
}

// MARK: - ProjectListViewDelegate

extension ProjectListViewController: ProjectListViewDelegate {
    func didSelectProject(at indexPath: IndexPath) {

    }

    func didTapProjectCreatorButton() {
        self.coordinator.showProjectCreator()
    }
}
