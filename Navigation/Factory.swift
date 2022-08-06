//
//  LoginInspector.swift
//  Navigation
//
//  Created by Suharik on 02.06.2022.
//

import Foundation

protocol LoginFactory {
    func returnLoginInspector() -> LoginInspector
}

class MyLoginFactory: LoginFactory {
    static let shared = MyLoginFactory()

    func returnLoginInspector() -> LoginInspector {
        let inspector = LoginInspector()
        return inspector
    }
}
