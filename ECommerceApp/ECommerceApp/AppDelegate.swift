//
//  AppDelegate.swift
//  ECommerceApp

import UIKit
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if !UserDefaults.standard.bool(forKey: kIslaunched){
            insertInitialData()
        }
        
        UserDefaults.standard.setValue(true, forKey: kIslaunched)
        IQKeyboardManager.shared.enable = true
        return true
    }

    
    func insertInitialData(){
        let provider1 = DBManager.shared.addProvider(name: "Vijay")
        DBManager.shared.addProvider(name: "Krishna")
        DBManager.shared.addProvider(name: "Mahammed")
        DBManager.shared.addProvider(name: "Asif")
        let productName = "iPhone 11"
        let description = "iPHone 11 is good product for use and it is very fast."
        let price = "150"
        DBManager.shared.addProduct(name: productName, description: description, price: price, provider: provider1)
    }

}

