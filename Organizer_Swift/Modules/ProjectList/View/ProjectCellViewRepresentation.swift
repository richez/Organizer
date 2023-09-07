//
//  ProjectCellViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

struct ProjectCellViewRepresentation {
    var backgroundColor: UIColor = .clear
    var selectedBackgroundColor: UIColor = .projectCellSelectedBackground

    var titleColor: UIColor = .projectTitle
    var titleFont: UIFont = .systemFont(ofSize: 15, weight: .bold)

    var dateColor: UIColor = .projectDate
    var dateFont: UIFont = .systemFont(ofSize: 13, weight: .light)

    var separatorColor: UIColor = .projectCellSeparator
    var separatorHeight: CGFloat = 1
}
