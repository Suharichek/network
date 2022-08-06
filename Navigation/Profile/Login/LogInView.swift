////
////  LogInView.swift
////  Navigation
////
////  Created by Suharik on 23.03.2022.
////
//
//import UIKit
//
//class LogInView: UIView {
//    
//    var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        return scrollView
//    }()
//    
//    //    var loginButton: UIButton = {
//    //        let button = UIButton()
//    //        button.backgroundColor = UIColor.init(named: "Color")
//    //        button.setTitle("Войти", for: .normal)
//    //        button.layer.cornerRadius = 10
//    //        button.addTarget(self, action: #selector(LogInViewController.loginButtonPressed), for: .touchUpInside)
//    //        return button
//    //    }()
//    
//    lazy var loginButton: CustomButton = {
//        let button = CustomButton (
//            title: "Войти",
//            titleColor: UIColor.white,
//            backColor: UIColor.init(named: "Color")!,
//            backImage: UIImage(named: "blue_pixel") ?? UIImage()
//        )
//        button.addTarget(self, action: #selector(LogInViewController.loginButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    //     lazy var loginButton: CustomButton = {
//    //        let button = CustomButton (
//    //            title: "Войти",
//    //            titleColor: UIColor.white,
//    //            backColor: UIColor.init(named: "Color") ?? .black
//    //        )
//    //        button.addTarget(self, action: #selector(LogInViewController.loginButtonPressed), for: .touchUpInside)
//    //        return button
//    //    }()
//    
//    var loginImageView: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(named: "logo")
//        return image
//    }()
//    
//    var emailTextField: UITextField = {
//        let email = UITextField()
//        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
//        email.leftView = paddingView
//        email.leftViewMode = .always
//        email.backgroundColor = .systemGray6
//        email.textColor = .black
//        email.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        email.layer.cornerRadius = 10
//        email.layer.borderWidth = 0.5
//        email.layer.borderColor = UIColor.lightGray.cgColor
//        email.font = UIFont.systemFont(ofSize: 16)
//        email.autocapitalizationType = .none
//        email.attributedPlaceholder = NSAttributedString.init(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
//        return email
//    }()
//    
//    var passwordTextField: UITextField = {
//        let password = UITextField()
//        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
//        password.leftView = paddingView
//        password.tintColor = UIColor(named: "MainColor")
//        password.leftViewMode = .always
//        password.backgroundColor = .systemGray6
//        password.textColor = .black
//        password.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        password.layer.cornerRadius = 10
//        password.layer.borderWidth = 0.5
//        password.layer.borderColor = UIColor.lightGray.cgColor
//        password.font = UIFont.systemFont(ofSize: 16)
//        password.autocapitalizationType = .none
//        password.attributedPlaceholder = NSAttributedString.init(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
//        password.isSecureTextEntry = true
//        return password
//    }()
//}
//
