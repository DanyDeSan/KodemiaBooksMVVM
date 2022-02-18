//
//  UIVIewController++.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 17/02/22.
//

import Foundation
import UIKit

extension UIViewController {
    func activateHideKeyboardGestureRecognizer() {
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func hideKeyboardOnTap() {
        self.view.endEditing(true)
    }
}
