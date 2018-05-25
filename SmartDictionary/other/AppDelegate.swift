//
//  AppDelegate.swift
//  SmartDictionaty
//
//  Created by Андрей Коноплев on 21.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let context = CoreDataManager.sharedInstance.getMainContext()

        let currentLang = CurrentLanguageFabrique.getCurrentLang(context: context)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if currentLang == nil {
            CheckDeviceLocaleService.sendLocale()
            
            //choose view controller show
            let vc = UIStoryboard.create(.main).instantiateViewController(withIdentifier: "setUpWizard")
            window?.rootViewController = vc
        } else {
            let vc = UIStoryboard.create(.main).instantiateViewController(withIdentifier: "mainTabBar")
            window?.rootViewController = vc
        }
        return true
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

