//
//  AppDelegate.swift
//  Personal
//
//  Created by htmlprogrammist on 11/03/2022.
//  Copyright (c) 2022 htmlprogrammist. All rights reserved.
//

import UIKit
import Personal
import Resources
import Persistence

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let coreDataManager: CoreDataManagerProtocol = CoreDataManager(containerName: "Cookbook")
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let context = PersonalContext(moduleOutput: nil, moduleDependency: coreDataManager)
        let assembly = PersonalAssembly.assemble(with: context)
        
        let navController = UINavigationController(rootViewController: assembly.viewController)
        navController.navigationBar.prefersLargeTitles = true
        
        // Resources.Fonts
        Fonts.registerFonts()
        navController.navigationBar.largeTitleTextAttributes = [.font: Fonts.largeTitle()]
        navController.navigationBar.titleTextAttributes = [.font: Fonts.headline()]
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
