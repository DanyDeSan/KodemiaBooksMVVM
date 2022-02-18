//
//  LinkButton.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 17/02/22.
//

import UIKit

class LinkButton: UIButton {
    
    init(linkText: String, frame: CGRect) {
        super.init(frame: frame)
        initUI(title: linkText)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI(title: "")
    }
    
    func initUI(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        setTitleColor(.systemGray, for: .highlighted)
    }
    
}
