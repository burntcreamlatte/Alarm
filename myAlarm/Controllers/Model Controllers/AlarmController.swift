//
//  AlarmController.swift
//  myAlarm
//
//  Created by Aaron Shackelford on 11/11/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    //SoT
    var myAlarms: [Alarm] = []
    
    // MARK: - CRUD Functions
    
    //create new alarm
    func addNewAlarm(fireDate: Date, name: String, isEnabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, isEnabled: isEnabled)
            myAlarms.append(newAlarm)
    }
    //update alarm
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, isEnabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.isEnabled = isEnabled
    }
    //delete existing alarm
    func deleteAlarm(alarm: Alarm) {
        guard let indexOfAlarm = myAlarms.firstIndex(of: alarm) else { return }
        myAlarms.remove(at: indexOfAlarm)
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
}
