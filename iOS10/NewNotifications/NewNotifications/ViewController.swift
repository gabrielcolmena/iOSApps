//
//  ViewController.swift
//  NewNotifications
//
//  Created by Gabriel Colmenares on 7/17/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1 request permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(granted, error) in
        
            
            if granted{
                print("Notification access granted")
            }else{
                print(error?.localizedDescription ?? "")
            }
        })
    }

    @IBAction func notificationButtonPressed(_ sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: {success in
            if success{
                print("Succesfully schedule notification")
            }else{
                print("Error scheduling notification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()){
        
        let myImage = "walter"
        guard let image = Bundle.main.url(forResource: myImage, withExtension: "gif") else{
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: image, options: .none)
        
        let notif = UNMutableNotificationContent()
        notif.title = "Breaking bad -  Episode 5"
        notif.subtitle = "In the next episode of breaking bad"
        notif.body = "Hank starts looking for the new drug kingpin around town (unaware that it is Walt). Walt reveals that he has cancer at a family barbecue. Jesse goes to visit his family, and finds out that his younger brother, who is very successful in sports and music, is smoking marijuana."
        notif.attachments = [attachment]
        notif.categoryIdentifier = "myNotificationCategory"
        
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil{
                print(error.debugDescription)
                completion(false)
            }else{
                completion(true)
            }
            
        })
    }
}

