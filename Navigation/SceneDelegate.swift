//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Suharik on 11.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let appConfiguration:AppConfiguration = .one
        let tabBarController = UITabBarController()
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        let profileViewController = ProfileViewController(userService: TestUserService() as UserService, name: "testname")
        tabBarController.viewControllers = [feedViewController, profileViewController]
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        createPhotosArray()
        DispatchQueue.global().async {
             createPhotosArray()
         }
    }
    
    func createFeedViewController() -> UINavigationController {
        let feedViewController = FeedViewController()
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "doc.richtext"), tag: 0)
        return UINavigationController(rootViewController: feedViewController)
    }
    func createLoginViewController() -> UINavigationController {
        let logInViewController = LogInViewController()
        let inspector = MyLoginFactory.shared.returnLoginInspector()
        logInViewController.delegate = inspector
        logInViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
        return UINavigationController(rootViewController: logInViewController)
    }

    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = .white
        tabBarController.viewControllers = [createFeedViewController(), createLoginViewController()]
        return tabBarController
    }
    
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}



