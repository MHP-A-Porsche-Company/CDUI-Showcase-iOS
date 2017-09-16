//
//  AppDelegate.swift
//  cdui-showcase
//
//  Created by Christoph Albert on 16.09.17.
//  Copyright © 2017 MHP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let streamViewModel = StreamViewModel()
    let streamController = StreamController.create(viewModel: streamViewModel)

    let navigationController = UINavigationController(rootViewController: streamController)
    navigationController.isNavigationBarHidden = true

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

    return true
  }
}
