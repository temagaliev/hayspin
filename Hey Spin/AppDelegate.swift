//
//  AppDelegate.swift
//  Hey Spin
//
//  Created by Artem Galiev on 17.10.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        MainRouter.shared.showTmpMainScreen()
        
        return true
    }

}

