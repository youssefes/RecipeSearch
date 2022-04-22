//
//  AppDelegate.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - properties
    var window: UIWindow?
    var Coordinator : AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        Coordinator = AppCoordinator(Window: window!)

        steupNavigarionaBar()
        //MARK: - start app viewController
        Coordinator.start()
//        IQKeyboardManager.shared.enable = true
        return true
    }
    //MARK: -  steup NavigarionaBar
    private func steupNavigarionaBar(){
        UINavigationBar.appearance().barTintColor = UIColor.RecipeSearchUIColor.appColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
         UINavigationBar.appearance().isTranslucent = false
    
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor.RecipeSearchUIColor.appColor
            UINavigationBar.appearance().barTintColor = UIColor.RecipeSearchUIColor.appColor
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }


}

