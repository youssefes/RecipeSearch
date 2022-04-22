//
//  AppCoordinator.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//

import Foundation
import UIKit
protocol Coordinator {
    var mainNavigator : MainNavigator {get}
    var navigationController : UINavigationController? {get}
    func dismiss()
}

class AppCoordinator : Coordinator{
    
    //MARK: - properties
    var navigationController: UINavigationController?
    lazy var mainNavigator : MainNavigator = {
          return .init(coordintor: self)
    }()
    
    let window : UIWindow
    //MARK: - init
    init(Window : UIWindow = UIWindow()) {
        self.window = Window
    }
    
    //MARK: - dismiss viewController
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - start  viewController of app
    func start()  {
        let nav = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    //MARK: -   root ViewController of app
    var rootViewController : UIViewController {
        return mainNavigator.viewController(for: .RecipeSearchVC)
    }
}

