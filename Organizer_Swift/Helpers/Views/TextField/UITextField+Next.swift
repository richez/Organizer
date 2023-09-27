//
//  UITextField+Next.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 27/09/2023.
//

import UIKit

extension UITextField {
    func next() {
        let nextTag = self.tag + 1
        if let nextResponder = self.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            self.resignFirstResponder()
        }
    }
}
