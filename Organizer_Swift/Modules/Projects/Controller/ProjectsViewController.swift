//
//  ViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class ProjectsViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: ProjectsViewModelProtocol

    // MARK: - Initialization

    init(viewModel: ProjectsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func loadView() {
        self.view = ProjectsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
    }
}

private extension ProjectsViewController {
    // MARK: - Setup

    func setupNavigationBar() {
        self.title = self.viewModel.navigationBarTitle
        self.navigationController?.navigationBar.applyAppearance()
    }
}
