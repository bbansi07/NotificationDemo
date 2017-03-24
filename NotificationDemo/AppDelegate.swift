//
//  AppDelegate.swift
//  NotificationDemo
//
//  Created by Zeitech Solutions on 14/03/17.
//
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let settings = UIUserNotificationSettings(types: [UIUserNotificationType.alert,UIUserNotificationType.badge,UIUserNotificationType.sound], categories: nil)
        
        UIApplication.shared.registerUserNotificationSettings(settings)
        
        application.registerForRemoteNotifications()
        
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert,.sound,.badge],
                completionHandler: { (granted,error) in
                    
            }
                
            )
        } else {
            // Fallback on earlier versions
        }
        return true
    }
    func scheduleNotification(at date: Date) {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        if #available(iOS 10.0, *) {
            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
            let content = UNMutableNotificationContent()
            content.title = "Tutorial Reminder"
            content.body = "Just a reminder to read your tutorial over at appcoda.com!"
            content.sound = UNNotificationSound.default()
            
            let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("Uh oh! We had an error: \(error)")
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    //MARK: - Notification
    func fireNotification(){
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            let options : UNAuthorizationOptions = [.alert,.sound]
            
            center.requestAuthorization(options: options){
                (granted,error) in
                if !granted{
                    print("somthing went wrong")
                }
            }
            
            center.getNotificationSettings(completionHandler: { (settings) in
                if settings.authorizationStatus != .authorized{
                    print("notifications ain't allowed")
                }
            })
            let content = UNMutableNotificationContent()
            
            content.title = "Title"
            content.body = "Body here"
            content.sound = UNNotificationSound.default()
            
            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: true)
            let date = Date(timeIntervalSinceNow: 3600)
            
            let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            
            let identifier = "UYLLocalNotification"
            
            let request = UNNotificationRequest(identifier : identifier , content : content , trigger : trigger)
            center.add(request, withCompletionHandler:nil)
            
        } else {
            print("iOS version not supported")
            // Fallback on earlier versions
        }
        
    }
    //MARK :- notification delegate methods by ununotification delegate
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("User Info === \(notification.request.content.userInfo)")
        completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.badge,UNNotificationPresentationOptions.sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Info === \(response.notification.request.content.userInfo)")
        completionHandler()
    }
    
    //MARK :- aplication delegate method for handle notification
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        let chareterSet = CharacterSet(charactersIn : "<>")
        print("charecterset wjo;e registering : \(chareterSet)")
        //  let deviceTokenString :String = (deviceToken.description as NSString).trimmingCharacters(in: characterSet) as NSString).replacingOccurrences(of: " ", with: "") as String
        
        //  print(deviceTokenString)
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

