import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Permission granted: \(granted)")
            }
        }
    }
    
    func scheduleDailyNotification(at hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Registro de Horas Predicadas"
        content.body = "¿Cuántas horas predicaste hoy?"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
