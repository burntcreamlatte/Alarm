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
    
    //does this need to be optional? ie: "[Alarm]?"
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
}
