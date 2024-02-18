//
//  AppDelegate.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 15/02/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller = HomeScreenController()
        setRootViewController(controller)
        return true
    }
    
    //MARK: Root controller
    private func setRootViewController(_ controller: UIViewController) {
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.isHidden = true
        navigationController.view.backgroundColor = .white
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationItem.backBarButtonItem?.title = ""
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

