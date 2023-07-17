//
//  View+Extension.swift
//  JetDevsHomeWork
//
//  Created by MOB-051119-002 on 17/07/23.
//

import UIKit

extension UIView {
    
    func borderWithCornerRadius(radius: Int = 5, color: UIColor = .gray, borderWidth: CGFloat = 1) {
        self.layer.cornerRadius = 5
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
    }
}
