//
//  AppDelegate.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 16/01/2021.
//

import UIKit
import FourSquareAPI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = AppBuilder.production()
		window?.makeKeyAndVisible()

		return true
	}
}

