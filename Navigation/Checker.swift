//
//  Checker.swift
//  Navigation
//
//  Created by Suharik on 02.06.2022.
//

import Foundation

final class Checker {
    
    static let shared = Checker()
    
    private init() {}
    private let login = "yulia".hash
    private let password = "suharik".hash
    
    func checker (login: String, password: String) -> Bool {
        guard login.hash == self.login && password.hash == self.password else { return false }
        return true
    }
}

class LoginInspector: LoginViewControllerDelegate {
    func userValidation (log: String, pass: String) -> Bool {
        return Checker.shared.checker(login: log, password: pass)
    }
}
