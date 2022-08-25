//
//  LogInViewController.swift
//  Navigation
//
//  Created by Suharik on 23.03.2022.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate {
    func userValidation (log: String, pass: String) -> Bool
}

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    private var isLogin = false
    
    var delegate: LoginViewControllerDelegate!
    
    private lazy var logInScrollView: UIScrollView = {
        let logInScrollView = UIScrollView()
        return logInScrollView
    }()
    
    private lazy var contentView: UIView = {
        let logInHeaderView = UIView()
        return logInHeaderView
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton (
            title: "Войти",
            titleColor: UIColor.white,
            backColor: UIColor.init(named: "Color")!,
            backImage: UIImage(named: "blue_pixel") ?? UIImage()
        )
        return button
    }()
    
    private lazy var hackThePasswordButton: CustomButton = {
        let button = CustomButton (
            title: "Взлом пароля",
            titleColor: UIColor.white,
            backColor: UIColor.orange,
            backImage: UIImage()
        )
        return button
    }()
    
    public lazy var loginTextField: UITextField = {
        let textField = logPassTextField(placeholder: "Email или номер телефона", secure: false)
        let icon = UIImageView(image: UIImage(systemName: "person.fill"))
        icon.tintColor = UIColor(named: "blue_pixel")
        textField.leftView = textFieldIcon(subView: icon)
        textField.addTarget(self, action: #selector(logInButtonAlpha), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = logPassTextField(placeholder: "Пароль", secure: true)
        let icon = UIImageView(image: UIImage(systemName: "lock.fill"))
        icon.tintColor = UIColor(named: "blue_pixel")
        textField.leftView = textFieldIcon(subView: icon)
        textField.addTarget(self, action: #selector(logInButtonAlpha), for: .editingChanged)
        return textField
    }()
    
    
    private lazy var loginAlertController: UIAlertController = {
        let alertController = UIAlertController(title: "Пользователь не найден", message: "Вы правильно ввели логин или пароль?", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Похоже нет", style: .default) { (_) -> Void in
        }
        alertController.addAction(acceptAction)
        return alertController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        setupContentViews()
        hideKeyboardWhenTappedAround()
        
        logInButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.logInButtonPressed()
        }
        
        hackThePasswordButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.hackPassword()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardShow),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func logPassTextField(placeholder: String, secure: Bool) ->  UITextField {
        let logPassTextField = UITextField()
        logPassTextField.leftViewMode = .always
        logPassTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: logPassTextField.frame.height))
        logPassTextField.placeholder = placeholder
        logPassTextField.layer.borderColor = UIColor.lightGray.cgColor
        logPassTextField.layer.borderWidth = 0.25
        logPassTextField.textColor = .black
        logPassTextField.font = UIFont.systemFont(ofSize: 16)
        logPassTextField.autocorrectionType = .no
        logPassTextField.autocapitalizationType = .none
        logPassTextField.keyboardType = .emailAddress
        logPassTextField.returnKeyType = .done
        logPassTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        logPassTextField.isSecureTextEntry = secure
        return logPassTextField
    }
    
    private func setupContentViews() {
        view.backgroundColor = .white
        view.addSubview(logInScrollView)
        logInScrollView.addSubview(contentView)
        contentView.addSubview(logo)
        contentView.addSubview(textFieldsStackView)
        contentView.addSubview(logInButton)
        contentView.addSubview(hackThePasswordButton)
        textFieldsStackView.addArrangedSubview(loginTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        setupLoginLayout()
    }
    
    func hackPassword() {
        let hack = BrutForce()
        var pass: String = ""
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        passwordTextField.leftView = textFieldIcon(subView: activityIndicator)
        passwordTextField.placeholder = "Взлом пароля..."
        activityIndicator.startAnimating()
        DispatchQueue.global().async {
            pass = hack.bruteForce(passwordToUnlock: "a$8")
            
            DispatchQueue.main.sync {
                self.passwordTextField.text = pass
                self.passwordTextField.isSecureTextEntry = false
                self.passwordTextField.placeholder = "Пароль"
                activityIndicator.stopAnimating()
                self.passwordTextField.leftView = self.textFieldIcon(subView: UIImageView(image: UIImage(systemName: "lock")))
                self.logInButtonAlpha()
            }
        }
    }
    
    private func setupLoginLayout() {
        
        logInScrollView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.centerX.centerY.equalTo(logInScrollView)
        }
        
        logo.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalTo(contentView).offset(120)
            make.centerX.equalTo(contentView)
        }
        
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(120)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(100)
        }
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(50)
        }
        
        hackThePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(50)
        }
    }
    @objc func logInButtonPressed(){
        let currentUserService = TestUserService()
        let profileViewController = ProfileViewController(userService: currentUserService, name: loginTextField.text!)
        if delegate?.userValidation(log: loginTextField.text!, pass: passwordTextField.text!) == true {
            isLogin = true
            navigationController?.pushViewController(profileViewController, animated: true)
            navigationController?.setViewControllers([profileViewController], animated: true)
        } else {
            present(loginAlertController, animated: true, completion: nil)
        }
    }
    
    @objc func keyboardShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            logInScrollView.contentOffset.y = keyboardRectangle.height - (logInScrollView.frame.height - logInButton.frame.maxY) + 16
        }
    }
    
    @objc func keyboardHide(_ notification: Notification){
        logInScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    @objc func logInButtonAlpha() {
        if loginTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
            logInButton.alpha = 1.0
            logInButton.isEnabled = true
        } else {
            logInButton.alpha = 0.5
            logInButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldIcon (subView: UIView) -> UIView {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        leftView.addSubview(subView)
        subView.center = leftView.center
        return leftView
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}



