//
//  ContentListView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import UIKit

protocol ContentListViewDelegate: AnyObject {
    func didSelectContent(at indexPath: IndexPath)
    func didTapSwipeAction(_ action: ContentListSwipeAction, at indexPath: IndexPath) -> Bool
    func didTapContextMenuAction(_ action: ContentListContextMenuAction, at indexPath: IndexPath)
    func didTapCreateButton()
}

final class ContentListView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ContentListViewRepresentation = .init()

    weak var delegate: ContentListViewDelegate?

    private var swipeActionConfigurations: [ContentListSwipeActionConfiguration] = []
    private var contextMenuTitle: String = ""
    private var contextMenuActionConfigurations: [ContentListContextMenuActionConfiguration] = []

    // MARK: View

    let tableView: UITableView = .init()
    private let createButton: FloatingActionButton = .init() // TODO: rename 'createButton'

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with configuration: ContentListViewConfiguration) {
        self.createButton.configure(
            with: self.viewRepresentation.createButtonViewRepresentation(imageName: configuration.createButtonImageName)
        )
        self.swipeActionConfigurations = configuration.swipeActions
        self.contextMenuTitle = configuration.contextMenuTitle
        self.contextMenuActionConfigurations = configuration.contextMenuActions
    }
}

private extension ContentListView {
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
        self.createButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.didTapCreateButton()
        }), for: .touchUpInside)

        self.addSubview(self.createButton)
        self.createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.createButton.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10
            ),
            self.createButton.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20
            )
        ])
    }
}

// MARK: - UITableViewDelegate

extension ContentListView: UITableViewDelegate {
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
