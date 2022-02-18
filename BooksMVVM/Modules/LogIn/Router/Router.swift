//
//  Router.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 17/02/22.
//

import Foundation
import UIKit

enum LogInRouter {
    case SignIn(Transitions?)
    case BooksListView(Transitions?)
    case none
    
    var view:  UIViewController? {
        switch self {
        case .SignIn: return SignInViewController()
        case .BooksListView : return UIViewController()
        case .none: return nil
        }
    }
}
