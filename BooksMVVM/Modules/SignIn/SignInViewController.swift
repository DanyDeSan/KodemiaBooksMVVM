//
//  SignInViewController.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 17/02/22.
//

import UIKit

final class SignInViewController: UIViewController {
    
    private lazy var userTextField: InputTextField = InputTextField(frame: CGRect(), placeHolder: Constants.userPlaceHolder)
    private lazy var emailTextField: InputTextField = InputTextField(frame: CGRect(), placeHolder: Constants.email)
    private lazy var passwordTextField: InputTextField = InputTextField(frame: CGRect(), placeHolder: Constants.passwordPlaceHolder)
    private lazy var confirmPassTextField: InputTextField = InputTextField(frame: CGRect(), placeHolder: Constants.passConfirm)
    
    private lazy var confirmButton: FilledButton = FilledButton(title: Constants.confirm, frame: CGRect())
    
    private lazy var cancelButton : UnfilledButton = UnfilledButton(title: Constants.cancel, frame: CGRect())
    
    private lazy var inputStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        [userTextField,
        emailTextField,
        passwordTextField,
         confirmPassTextField].forEach { stack.addArrangedSubview($0)}
        return stack
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        [confirmButton,cancelButton].forEach { stack.addArrangedSubview($0)}
        return stack
    }()
    
    private var viewModel: SignInViewModel = SignInViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initViewModel()
        activateHideKeyboardGestureRecognizer()
    }
    
    private func initUI() {
        view.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            inputStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            inputStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            inputStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -Constants.padding),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
        
        let constraints: [NSLayoutConstraint] = [passwordTextField,userTextField,confirmPassTextField,emailTextField,confirmButton,cancelButton].map { textfield in
            return textfield.heightAnchor.constraint(equalToConstant: Constants.heightTextFiel)
        }
        
        NSLayoutConstraint.activate(constraints)
        
        confirmButton.addTarget(self, action: #selector(self.didTapOnConfirmButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(self.didTapOnCancelButton), for: .touchUpInside)
        
        configureTextFields()
        
    }
    
    private func configureTextFields() {
        userTextField.autocapitalizationType = .words
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        confirmPassTextField.isSecureTextEntry = true
        userTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPassTextField.delegate = self
        userTextField.nextTextFieldToResign = emailTextField
        emailTextField.nextTextFieldToResign = passwordTextField
        passwordTextField.nextTextFieldToResign = confirmPassTextField
    }

    private func initViewModel() {
        userTextField.bind(to: viewModel.userName)
        emailTextField.bind(to: viewModel.userEmail)
        passwordTextField.bind(to: viewModel.userPassword)
        confirmPassTextField.bind(to: viewModel.confirmPassword)
        viewModel.router.valueChanged = { [weak self] router in
            switch router ?? .none {
            case .dismiss:
                self?.dismiss(animated: true, completion: nil)
            case .BooksList:
                guard let nextView = router?.nextView else { return }
                nextView.modalPresentationStyle = .fullScreen
                self?.present(nextView, animated: true, completion: nil)
            case .none:
                return 
            }
        }
    }
    
    @objc func didTapOnConfirmButton() {
        viewModel.didTapOnConfirm()
    }
    
    @objc func didTapOnCancelButton() {
        viewModel.didTapOnCancel()
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField: UITextField = (textField as? InputTextField)?.nextTextFieldToResign {
            nextTextField.becomeFirstResponder()
        } else {
            textField.endEditing(true)
        }
        return true
    }
}
