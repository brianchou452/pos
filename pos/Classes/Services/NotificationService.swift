//
//  NotificationService.swift
//  pos
//
//  Created by Brian Chou on 2024/11/24.
//

import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()

    func sendNewOrderNotification(order: Order) {
        let notificationId = "newOrderNotification-\(UUID().uuidString)"
        let content = UNMutableNotificationContent()
        content.title = "你有一筆新訂單"
        let orderItems = order.items.map { $0.name }.joined(separator: ", ")
        content.body = "訂單編號：\(order.id ?? "")\n商品：\(orderItems)\n總金額：\(order.total)"
        content.sound = UNNotificationSound.default

        content.userInfo = ["destination": "cc.seaotter.pos://order?orderId=\(order.id ?? "")"]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}
