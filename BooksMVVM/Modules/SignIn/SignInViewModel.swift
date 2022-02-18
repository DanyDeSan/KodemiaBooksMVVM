//
//  SignInViewModel.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 17/02/22.
//

import Foundation

final class SignInViewModel {
    var userName: Observable = Observable("")
    var userPassword: Observable = Observable("")
    var confirmPassword: Observable = Observable("")
    var userEmail: Observable = Observable("")
    var router: Observable = Observable(SignInRouter.none)
    
    var currentTextFieldEditing: Int = 0
    
    func didTapOnConfirm() {
        self.continueOnValidation()
    }
    
    func didTapOnCancel() {
        router.value = .dismiss
    }
    
    private func continueOnValidation() {
        
    }
    
}
