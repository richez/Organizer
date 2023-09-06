//
//  ProjectListView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

protocol ProjectListViewDelegate: AnyObject {
    func didSelectProject(at indexPath: IndexPath)
    func didSelectProjectCreatorButton()
}

final class ProjectListView: UIView {
    // MARK: - Properties

    private let viewRepresentation = ProjectsViewRepresentation()
    weak var delegate: ProjectListViewDelegate?

    let tableView: UITableView = UITableView()
    private lazy var projectCreatorButton: FloatingActionButton = {
        FloatingActionButton(
            viewRepresentation: self.viewRepresentation.newProjectButtonViewRepresentation
        )
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProjectListView {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = self.viewRepresentation.backgroundColor

        self.setupTableView()
        self.setupProjectCreatorButton()
    }

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.backgroundColor = self.viewRepresentation.tableViewBackgroundColor

        self.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setupProjectCreatorButton() {
        self.projectCreatorButton.addTarget(
            self,
            action: #selector(self.projectCreatorButtonTapped(_:)),
            for: .touchUpInside
        )

        self.addSubview(self.projectCreatorButton)
        self.projectCreatorButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.projectCreatorButton.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10
            ),
            self.projectCreatorButton.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20
            )
        ])
    }

    @IBAction
    func projectCreatorButtonTapped(_ sender: UIButton) {
        self.delegate?.didSelectProjectCreatorButton()
    }
}

// MARK: - UITableViewDelegate

extension ProjectListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewRepresentation.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectProject(at: indexPath)
    }
}


