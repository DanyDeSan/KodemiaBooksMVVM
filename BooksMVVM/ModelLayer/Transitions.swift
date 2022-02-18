//
//  Transitions.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 18/02/22.
//

import UIKit

enum Transitions {
    case leftRight
    case rightLeft
    
    var transition: CATransition {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        switch self {
        case .leftRight:
            transition.subtype = .fromLeft
        case .rightLeft:
            transition.subtype = .fromRight
        }
        
        return transition
    }
    
}
