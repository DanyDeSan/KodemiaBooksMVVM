//
//  Constants.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 16/02/22.
//

import UIKit

struct Constants {
    // View
    static let cornerRadius: CGFloat = 10
    static let borderWidth: CGFloat = 2
    static let padding: CGFloat = 10
    static let heightTextFiel: CGFloat = 50
    
    // Colors
    static let borderColor:UIColor = .systemBlue
    
    
    // String
    static let userPlaceHolder: String = "User"
    static let passwordPlaceHolder: String = "Password"
    static let dontHaveAccount: String = "Create an account"
    static let login: String = "Log In"
    static let email: String = "Email"
    static let passConfirm: String = "Confirm Password"
    static let confirm: String = "Confirm"
    static let cancel: String = "Cancel"
    
    // Utils
    static let emailPattern: String = #"^\S+@\S+\.\S+$"#
    
    // Others
    static let provisionaryRect: CGRect = CGRect()
}
