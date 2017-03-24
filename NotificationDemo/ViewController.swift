//
//  ViewController.swift
//  NotificationDemo
//
//  Created by Zeitech Solutions on 14/03/17.
//
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(temp), name:  Notification.Name("UYLLocalNotification"), object: nil)
        
        // Post notification
        
        NotificationCenter.default.post(name:  Notification.Name("UYLLocalNotification"), object: nil)
        
    }
    func temp(){
        print("notification fired")
        fireLocal()
    }
    
    func fireLocal(){
        
        // if isGrantedNotificationAccess{
        //add notification code here
        
        //Set the content of the notification
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "10 Second Notification Demo"
            content.subtitle = "From MakeAppPie.com"
            content.body = "Notification after 10 seconds - Your pizza is Ready!!"
            
            //Set the trigger of the notification -- here a timer.
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 10.0,
                repeats: false)
            
            //Set the request for the notification from the above
            let request = UNNotificationRequest(
                identifier: "10.second.message",
                content: content,
                trigger: trigger
            )
            
            //Add the notification to the currnet notification center
            UNUserNotificationCenter.current().add(
                request, withCompletionHandler: nil)
            
            //} else {
            // Fallback on earlier versions
            // }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

