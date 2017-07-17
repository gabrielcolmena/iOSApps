//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by Gabriel Colmenares on 7/17/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import SwiftGifOrigin

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard  let attatchment = notification.request.content.attachments.first else{
            return 
        }
        if attatchment.url.startAccessingSecurityScopedResource(){
            let imageData = try? Data.init(contentsOf: attatchment.url)
            if let img = imageData{
                imageView.image = UIImage.gif(data: img)
            }
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "emojiBump"{
            completion(.dismissAndForwardAction)
            
        }else if response.actionIdentifier == "dismiss"{
            completion(.dismissAndForwardAction)
        }
    }

}
