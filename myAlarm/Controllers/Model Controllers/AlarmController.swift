//
//  AlarmController.swift
//  myAlarm
//
//  Created by Aaron Shackelford on 11/11/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//
import Foundation
import UserNotifications

protocol AlarmScheduler: class {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}
extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "It's time"
        content.body = "Your alarm is going off"
        content.badge = 1
        content.sound = .default()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: "myAlarm", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (_) in
            print("User asked to get a local notification")
        }
    }
    func cancelUserNotifications(for alarm: Alarm) {
        
    }
}

class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    //SoT
    var myAlarms: [Alarm] = []
    
    weak var delegate: AlarmScheduler?
    
    // MARK: - CRUD Functions
    
    //create new alarm
    func addNewAlarm(fireDate: Date, name: String, isEnabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, isEnabled: isEnabled)
            myAlarms.append(newAlarm)
        saveToPersistentStore()
    }
    //update alarm
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, isEnabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.isEnabled = isEnabled
        saveToPersistentStore()
    }
    //delete existing alarm
    func deleteAlarm(alarm: Alarm) {
        guard let indexOfAlarm = myAlarms.firstIndex(of: alarm) else { return }
        myAlarms.remove(at: indexOfAlarm)
        saveToPersistentStore()
    }
    //toggle switch for alarms
    func toggleIsOn(for alarm: Alarm) {
        alarm.isEnabled = !alarm.isEnabled
    }
    
    
    // MARK: - Data Persistence Methods
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let alarmLocation = "alarm.json"
        let url = documentDirectory.appendingPathComponent(alarmLocation)
        print(url)
        return url
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let alarmData = try jsonEncoder.encode(myAlarms)
            try alarmData.write(to: fileURL())
        } catch {
            print("ERROR encoding data: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let alarmData = try Data(contentsOf: fileURL())
            let decodedAlarms = try jsonDecoder.decode([Alarm].self, from: alarmData)
            myAlarms = decodedAlarms
        } catch {
            print("ERROR loading from persistent store: \(error.localizedDescription)")
        }
    }
}//end of class
