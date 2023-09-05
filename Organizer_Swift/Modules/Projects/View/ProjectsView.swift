//
//  ProjectsView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

protocol ProjectsViewDelegate: AnyObject {
    func didSelectRow(at indexPath: IndexPath)
}

final class ProjectsView: UIView {
    // MARK: - Properties

    private let viewRepresentation = ProjectsViewRepresentation()
    weak var delegate: ProjectsViewDelegate?

    let tableView: UITableView = UITableView()

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
    }

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.backgroundColor = self.viewRepresentation.tableViewBackgroundColor

        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate

extension ProjectsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewRepresentation.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectRow(at: indexPath)
    }
}
