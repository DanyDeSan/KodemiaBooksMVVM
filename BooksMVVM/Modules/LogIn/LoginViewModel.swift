//
//  LoginViewModel.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 16/02/22.
//

import Foundation

final class LoginViewModel {
    var userInput: Observable<String> = Observable<String>("")
    var userPassword: Observable<String> = Observable<String>("")
    var router: Observable<LogInRouter> = Observable<LogInRouter>(.none)
    
    func didTapOnButton() {
        router.value = .SignIn(nil)
    }
    
    
    func didTapOnLogin() {
        continueOnLoginProcess()
    }
    
    private func continueOnLoginProcess() {
        guard validateEmailAddress(),
              validatePassword() else { return }
        router.value = .BooksListView(.leftRight)
        
    }
    
    private func validatePassword() -> Bool {
        guard let password: String = userPassword.value else { return false }
        return password != ""
    }
    
    private func validateEmailAddress() -> Bool  {
        guard let userEmail: String = userInput.value,
              let emailRegex: NSRegularExpression = try? NSRegularExpression(pattern: Constants.emailPattern, options: []) else { return false }
        let range: NSRange = NSRange(userEmail.startIndex ..< userEmail.endIndex, in: userEmail)
        let validationResult = emailRegex.matches(in: userEmail, options: [], range: range)
        
        return !validationResult.isEmpty
    }
    
}
