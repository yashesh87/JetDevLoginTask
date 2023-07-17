//
//  UIVIewController+Toast.swift
//  JetDevsHomeWork
//
//  Created by MOB-051119-002 on 17/07/23.
//

import UIKit
import Toast_Swift

extension UIViewController {
    func openAlert(_ message: String?, duration: TimeInterval = ToastManager.shared.duration, position: ToastPosition = ToastManager.shared.position, flag:Bool, completion: ((_ didTap: Bool) -> Void)? = nil) {
        
        self.view.makeToast(message, duration: duration, position: position) { didTap in
            if didTap {
                print("completion from tap")
            } else {
                print("completion without tap")
            }
        }
        ToastManager.shared.isTapToDismissEnabled = true
    }
}
