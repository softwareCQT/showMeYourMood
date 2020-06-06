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

let accountGetURL = "/api/ledger/get"
let accountSumURL = "/api/ledger/sum"
let accountDeleteURL = "/api/ledger/delete/"
let accountSaveURL = "/api/ledger/save"
let accountUpdateURL = "/api/ledger/update"

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
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        registerAPN()
        return true
    }
    
    func registerAPN() {
        let center = UNUserNotificationCenter.current()// 获取当前通知中心
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (isSuccess, error) in// 设定通知提示
            print("regist is \(isSuccess && error == nil ? "success" : "failure")")// 判断是否配置成功
        }
        center.delegate = self// 设定代理.注意代理要遵守UNUserNotificationCenterDelegate
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
    
    // 当程序在前台时收到通知会触发
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler(UNNotificationPresentationOptions.alert)
        
        
    }
    
    
}

//    发送一个本地通知
func sendNotice(date: Date, body: String) {
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    
    content.title = "必备记"
    content.subtitle = "别忘了您的代办事项"
    content.body = body
    content.categoryIdentifier = "categoryIdentifier"
    
    let interval = date.timeIntervalSinceNow
    guard interval > 0 else {
        return
    }
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
    
    let req = UNNotificationRequest.init(identifier: "本地通知", content: content, trigger: trigger)
    
    center.add(req) { (error) in
        print("******\(String(describing: error))******")
    }
    
}
