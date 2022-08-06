//
//  Model.swift
//  Navigation
//
//  Created by Suharik on 25.06.2022.
//

import Foundation
import UIKit

final class Model {
    
    let password = "Парольчик"
    
    func check(word: String) {
        guard word != "" else { return }
        
        if word == password {
            NotificationCenter.default.post(name: NSNotification.Name.codeGreen, object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name.codeRed, object: nil)
        }
    }
    
    private lazy var passwordAlert: UIAlertController = {
        let alertController = UIAlertController(
            title: "Неверный пароль!",
            message: "",
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        return alertController
    }()
}

public extension NSNotification.Name {
    static let codeRed = NSNotification.Name("codeRed")
    static let codeGreen = NSNotification.Name("codeGreen")
}
