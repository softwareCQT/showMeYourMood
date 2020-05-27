//
//  AppDelegate.swift
//  Note
//
//  Created by 峰 on 2020/4/26.
//  Copyright © 2020 峰. All rights reserved.
//

import UIKit

let baseURL = "http://47.97.186.90:8002"

let loginURL = "/api/user/login"
let logonURL = "/api/user/register"
let validURL = "/api/user/code/valid"
let passwordCodeURL = "/api/user/password/code/send"
let registerCodeURL = "/api/user/register/code/send"
let updatePasswordURL = "/api/user/password/update"

let noteGetURL = "/api/diary/get"
let noteSaveURL = "/api/diary/save"
let noteDeleteURL = "/api/diary/delete/"
let noteUpdateURL = "/api/diary/update"

let memoGetURL = "/api/memorandum/get"
let memoDeleteURL = "/api/memorandum/delete/"
let memoUpdateURL = "/api/memorandum/update"
let memoSaveURL = "/api/memorandum/save"

var Authorization : String? = FFUserDefalut.value(forKey: "Authorization") as? String {
    didSet {
        if let value = Authorization {
            FFUserDefalut.saveValue(value, forKey: "Authorization")
        }
    }
}

let NoteCacheFilePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0].appending("Cache.plist")
let AccountsFilePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0].appending("Accounts.plist")

var NoteCache : MyNote? = NSKeyedUnarchiver.unarchiveObject(withFile: NoteCacheFilePath) as? MyNote {
    didSet {
        if let value = NoteCache {
            NSKeyedArchiver.archiveRootObject(value, toFile: NoteCacheFilePath)
        }
    }
}

var AppWindow: UIWindow?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

