//
//  AppDelegate.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import  Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        // Use Firebase library to configure APIs  
        FirebaseApp.configure()
        
        let center = UNUserNotificationCenter.current()

        // ------------------------------------
        // 前準備: ユーザに通知の許可を求める
        // ------------------------------------

        // request to notify for user
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Allowed")
            } else {
                print("Didn't allowed")
            }
        }
        
        
        GADMobileAds.configure(withApplicationID:"ca-app-pub-7252408232726748~6308377965")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        let trigger:UNNotificationTrigger
        let content = UNMutableNotificationContent()
        let ud = UserDefaults.standard
        var time = ud.object(forKey: "NotificationTime") as? Date
        let component = Calendar.current.dateComponents([.hour, .minute], from: time ?? Date())
        trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
        
        
        content.title = ""
        content.body = "メモを活用して日常を振り返ろう"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: "output_notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

