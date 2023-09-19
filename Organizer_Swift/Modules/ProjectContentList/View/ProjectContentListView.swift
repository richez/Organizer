//
//  ProjectContentListView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

protocol ProjectContentListViewDelegate: AnyObject {
    func didSelectContent(at indexPath: IndexPath)
    func didTapSwipeAction(_ action: ProjectContentListSwipeAction, at indexPath: IndexPath) -> Bool
    func didTapContextMenuAction(_ action: ProjectContentListContextMenuAction, at indexPath: IndexPath)
    func didTapCreateButton()
}

final class ProjectContentListView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ProjectContentListViewRepresentation = .init()

    weak var delegate: ProjectContentListViewDelegate?

    var swipeActionConfigurations: [ProjectContentListSwipeActionConfiguration] = []
    var contextMenuTitle: String = ""
    var contextMenuActionConfigurations: [ProjectContentListContextMenuActionConfiguration] = []

    // MARK: View

    let tableView: UITableView = .init()
    let contentCreatorButton: FloatingActionButton = .init()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with configuration: ProjectContentListViewConfiguration) {
        self.contentCreatorButton.configure(
            with: self.viewRepresentation.createButtonViewRepresentation(imageName: configuration.createButtonImageName)
        )
        self.swipeActionConfigurations = configuration.swipeActions
        self.contextMenuTitle = configuration.contextMenuTitle
        self.contextMenuActionConfigurations = configuration.contextMenuActions
    }
}

private extension ProjectContentListView {
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
        self.contentCreatorButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.didTapCreateButton()
        }), for: .touchUpInside)

        self.addSubview(self.contentCreatorButton)
        self.contentCreatorButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentCreatorButton.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10
            ),
            self.contentCreatorButton.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20
            )
        ])
    }
}

// MARK: - UITableViewDelegate

extension ProjectContentListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewRepresentation.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectContent(at: indexPath)
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
