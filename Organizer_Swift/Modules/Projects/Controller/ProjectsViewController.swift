//
//  ViewController.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 04/09/2023.
//

import UIKit

final class ProjectsViewController: UIViewController {
    // MARK: - Life Cycle

    override func loadView() {
        self.view = ProjectsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
