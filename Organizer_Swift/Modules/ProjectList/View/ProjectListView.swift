//
//  ProjectListView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

protocol ProjectListViewDelegate: AnyObject {
    func didSelectProject(at indexPath: IndexPath)
    func didTapDelete(at indexPath: IndexPath)
    func didTapEdit(at indexPath: IndexPath)
    func didTapProjectCreatorButton()
}

final class ProjectListView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ProjectListViewRepresentation = .init()
    weak var delegate: ProjectListViewDelegate?

    let tableView: UITableView = .init()
    let projectCreatorButton: FloatingActionButton = .init()

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
        self.tableView.directionalLayoutMargins = self.viewRepresentation.tableViewEdgeInsets
        self.tableView.separatorStyle = self.viewRepresentation.tableViewseparatorStyle

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
        self.projectCreatorButton.setup(
            with: self.viewRepresentation.projectCreatorButtonViewRepresentation
        )

        self.projectCreatorButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.didTapProjectCreatorButton()
        }), for: .touchUpInside)

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
}

// MARK: - UITableViewDelegate

extension ProjectListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewRepresentation.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectProject(at: indexPath)
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            configuration: self.viewRepresentation.swipeDeleteViewRepresentation,
            handler: { [weak self] _, _, completionHandler in
                self?.delegate?.didTapDelete(at: indexPath)
                completionHandler(true)
            }
        )
        let editActions = UIContextualAction(
            configuration: self.viewRepresentation.swipeEditViewRepresentation,
            handler: { [weak self] _, _, completionHandler in
                self?.delegate?.didTapEdit(at: indexPath)
                completionHandler(true)
            }
        )
        return UISwipeActionsConfiguration(actions: [deleteAction, editActions])
    }
}
