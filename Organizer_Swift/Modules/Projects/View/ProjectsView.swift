//
//  ProjectsView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

protocol ProjectsViewDelegate: AnyObject {
    func didSelectProject(at indexPath: IndexPath)
    func didSelectNewProject()
}

final class ProjectsView: UIView {
    // MARK: - Properties

    private let viewRepresentation = ProjectsViewRepresentation()
    weak var delegate: ProjectsViewDelegate?

    let tableView: UITableView = UITableView()
    private lazy var newProjectButton: FloatingActionButton = {
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

private extension ProjectsView {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = self.viewRepresentation.backgroundColor

        self.setupTableView()
        self.setupFloatingActionButton()
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

    func setupFloatingActionButton() {
        self.newProjectButton.addTarget(
            self,
            action: #selector(self.newProjectButtonTapped(_:)),
            for: .touchUpInside
        )

        self.addSubview(self.newProjectButton)
        self.newProjectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.newProjectButton.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10
            ),
            self.newProjectButton.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20
            )
        ])
    }

    @IBAction
    func newProjectButtonTapped(_ sender: UIButton) {
        self.delegate?.didSelectNewProject()
    }
}

// MARK: - UITableViewDelegate

extension ProjectsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewRepresentation.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectProject(at: indexPath)
    }
}


