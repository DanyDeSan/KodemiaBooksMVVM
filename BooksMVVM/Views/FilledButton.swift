//
//  FilledButton.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 17/02/22.
//

import UIKit

class FilledButton: UIButton {

    init(title: String, frame: CGRect) {
        super.init(frame: frame)
        initUI(title: title)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initUI(title: String) {
        setTitle(title, for: .normal)
        backgroundColor = .systemBlue
        layer.masksToBounds = true
        layer.cornerRadius = Constants.cornerRadius
    }
}
