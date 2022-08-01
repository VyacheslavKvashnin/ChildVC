//
//  AppDelegate.swift
//  ChildVC
//
//  Created by Вячеслав Квашнин on 01.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        window.rootViewController = ContainerViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

