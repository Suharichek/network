//
//  User.swift
//  Navigation
//
//  Created by Suharik on 29.05.2022.
//

import Foundation
import UIKit

protocol UserService {
    func userIdentify (name: String) -> User?
}

final class User {
    
    let fullName: String
    let avatar: UIImage?
    let status: String
    
    init ( fullName: String, avatar: UIImage, status: String) {
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

final class TestUserService: UserService {
    
    let user = User(
        fullName: "yulia",
        avatar: UIImage(named: "myava")!,
        status: "Is it suharik?"
    )
    
    func userIdentify(name: String) -> User? {
        guard name == user.fullName else { return nil }
        return self.user
    }
}

final class CurrentUserService: UserService {
    
    let user = User(
        fullName: "Yulia Sukhareva",
        avatar: UIImage(named: "myavatar")!,
        status: "Releasek"
    )
    
    func userIdentify(name: String) -> User? {
        guard name == user.fullName else { return nil }
        return self.user
    }
}
