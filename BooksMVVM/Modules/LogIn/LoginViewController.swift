//
//  ViewController.swift
//  BooksMVVM
//
//  Created by L Daniel De San Pedro on 16/02/22.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private lazy var viewModel: LoginViewModel = LoginViewModel()
    
    private lazy var userInputTextField: InputTextField = InputTextField(frame: CGRect(), placeHolder: Constants.userPlaceHolder)
    
    private lazy var passwordInputTextField: InputTextField = InputTextField(frame: CGRect(), placeHolder: Constants.passwordPlaceHolder)
    
    private lazy var createAccountButton: LinkButton = LinkButton(linkText: Constants.dontHaveAccount, frame: CGRect())
    
    private lazy var loginButton: FilledButton = FilledButton(title: Constants.login, frame: CGRect())
    
    private lazy var tableView1: UITableView = UITableView()
    private lazy var tableView2: UITableView = UITableView()
    
    private lazy var stackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        [userInputTextField,
         passwordInputTextField].forEach { stack.addArrangedSubview($0)}
        view.addSubview(stack)
        return stack
    }()
    
    
    private lazy var buttonStackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        [loginButton,createAccountButton].forEach { stack.addArrangedSubview($0)}
        view.addSubview(stack)
        return stack
    }()
    
    private var inputStackViewBottomConstraint: NSLayoutConstraint?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniUI()
        initViewModel()
        activateHideKeyboardGestureRecognizer()
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView1.tag = 1
        tableView2.tag = 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardEvents()
    }
    
    deinit {
        unsubscribeToKeyboardEvents()
    }
    
    func initViewModel() {
        // Aqui establecemos la conexion entre viewmodel y el viewcontroller
        viewModel.viewContoller = self
        // Aqui se hace binding de los observadores
        userInputTextField.bind(to: viewModel.userInput)
        passwordInputTextField.bind(to: viewModel.userPassword)
        viewModel.router.valueChanged = { [weak self] router in
            guard let nextView: UIViewController = router?.view else { return }
            nextView.modalPresentationStyle = .fullScreen
            switch router! {
            case .BooksListView(let transition):
                if let transition = transition {
                    self?.configureTransition(transition: transition)
                }
                self?.present(nextView, animated: true, completion: nil)
            case .SignIn(let transition):
                if let transition = transition {
                    self?.configureTransition(transition: transition)
                }
                self?.present(nextView, animated: true, completion: nil)
            case .none:
                return
                
            }
        }
    }
    
    private func configureTransition(transition: Transitions) {
        view.window?.layer.add(transition.transition, forKey: kCATransition)
    }
    
    func iniUI() {
        view.backgroundColor = .systemBackground
        inputStackViewBottomConstraint = stackView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -20)
        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:  -Constants.padding),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            loginButton.heightAnchor.constraint(equalToConstant: Constants.heightTextFiel),
            createAccountButton.heightAnchor.constraint(equalToConstant: Constants.heightTextFiel),
            inputStackViewBottomConstraint!,
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            userInputTextField.heightAnchor.constraint(equalToConstant: Constants.heightTextFiel),
            passwordInputTextField.heightAnchor.constraint(equalToConstant: Constants.heightTextFiel)
        ])
        
        createAccountButton.addTarget(self, action: #selector(self.didTapOnButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(self.didTapOnLoginButton), for: .touchUpInside)
        configureTextFields()
    }
    
    
    @objc func didTapOnButton() {
        viewModel.didTapOnButton()
    }
    
    @objc func didTapOnLoginButton() {
        viewModel.didTapOnLogin()
    }
    
    private func subscribeToKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotifications(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func unsubscribeToKeyboardEvents() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureTextFields() {
        self.userInputTextField.keyboardType = .emailAddress
        self.userInputTextField.autocapitalizationType = .none
        self.passwordInputTextField.autocapitalizationType = .none
        self.passwordInputTextField.isSecureTextEntry = true
    }
    
    @objc func keyboardNotifications(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.inputStackViewBottomConstraint?.constant = -20
        } else {
            self.inputStackViewBottomConstraint?.constant = -(endFrame?.size.height ?? 0.0)
        }
        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: animationCurve,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
        
    }
    
    func goToNextView() {
        // Que sea llamada desde el view model y que nos lleve a la siguiente vista.
        let viewController: UIViewController = UIViewController()
        self.present(viewController, animated: true, completion: nil)
    }
    
}


extension LoginViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1 {
            // viewModel.didSelectRowAt(indexPath:)
        } else {
            
        }
    }
}

extension LoginViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
