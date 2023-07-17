//
//  FilledBlueButton.swift
//  JetDevsHomeWork
//
//  Created by MOB-051119-002 on 17/07/23.
//

import UIKit

class FilledBlueButton: UIButton {

    @IBInspectable
    var enabledColor: UIColor = .blue {
        didSet {
            updateButtonColor()
        }
    }
    
    @IBInspectable
    var disabledColor: UIColor = .gray {
        didSet {
            updateButtonColor()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateButtonColor()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        clipsToBounds = true
        updateButtonColor()
    }

    private func updateButtonColor() {
        if isEnabled {
            backgroundColor = self.enabledColor
        } else {
            backgroundColor = self.disabledColor
        }
    }
}
