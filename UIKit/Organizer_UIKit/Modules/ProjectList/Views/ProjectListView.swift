//
//  ProjectListView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

@MainActor
protocol ProjectListViewDelegate: AnyObject {
    func didSelectProject(at indexPath: IndexPath)
    func didTapSwipeAction(_ action: ProjectListSwipeAction, at indexPath: IndexPath) -> Bool
    func didTapContextMenuAction(_ action: ProjectListContextMenuAction, at indexPath: IndexPath)
    func didTapCreateButton()
}

final class ProjectListView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ProjectListViewRepresentation = .init()
    weak var delegate: ProjectListViewDelegate?

    private var swipeActionConfigurations: [ProjectListSwipeActionConfiguration] = []
    private var contextMenuTitle: String = ""
    private var contextMenuActionConfigurations: [ProjectListContextMenuActionConfiguration] = []

    // MARK: Views

    let tableView: UITableView = .init()
    let createButton: FloatingActionButton = .init()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with configuration: ProjectListViewConfiguration) {
        self.createButton.setImage(
            self.viewRepresentation.createButtonImage(named: configuration.createButtonImageName),
            for: .normal
        )
        self.swipeActionConfigurations = configuration.swipeActions
        self.contextMenuTitle = configuration.contextMenuTitle
        self.contextMenuActionConfigurations = configuration.contextMenuActions
    }
}

private extension ProjectListView {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = self.viewRepresentation.backgroundColor

        self.setupTableView()
        self.setupCreateButton()
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

    func setupCreateButton() {
        self.createButton.setup(with: self.viewRepresentation.createButtonViewRepresentation)

        self.createButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.didTapCreateButton()
        }), for: .touchUpInside)

        self.addSubview(self.createButton)
        self.createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.createButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.createButton.trailingAnchor.constraint(
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
        let actions = self.swipeActionConfigurations.map { configuration in
            UIContextualAction(
                style: self.viewRepresentation.swipeActionStyle(for: configuration.action),
                title: configuration.title,
                backgroundColor: self.viewRepresentation.swipeActionBackgroundColor(for: configuration.action),
                imageName: configuration.imageName,
                handler: { [weak self] _, _, completionHandler in
                    let didPerformAction = self?.delegate?.didTapSwipeAction(configuration.action, at: indexPath) ?? false
                    completionHandler(didPerformAction)
                }
            )
        }
        return UISwipeActionsConfiguration(actions: actions)
    }

    func tableView(_ tableView: UITableView, 
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(actionProvider:  { _ in
            let actions = self.contextMenuActionConfigurations.map { configuration in
                UIAction(
                    title: configuration.title,
                    image: self.viewRepresentation.contextMenuActionImage(imageName: configuration.imageName),
                    attributes: self.viewRepresentation.contextMenuActionAttributes(for: configuration.action),
                    handler: { [weak self] _ in
                        self?.delegate?.didTapContextMenuAction(configuration.action, at: indexPath)
                    }
                )
            }
            return UIMenu(title: self.contextMenuTitle, children: actions)
        })
    }
}
