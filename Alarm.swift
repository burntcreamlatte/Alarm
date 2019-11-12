//
//  Alarm.swift
//  myAlarm
//
//  Created by Aaron Shackelford on 11/11/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation

class Alarm: Equatable, Codable {
    var fireDate: Date
    var name: String
    var uuid: String
    var isEnabled: Bool
    var fireTimeAsString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: fireDate)
    }
    
    init(fireDate: Date, name: String, uuid: String = "", isEnabled: Bool) {
        self.fireDate = fireDate
        self.name = name
        self.uuid = uuid
        self.isEnabled = isEnabled
    }
    
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return
            lhs.fireDate == rhs.fireDate &&
            lhs.name == rhs.name &&
            lhs.uuid == rhs.uuid &&
            lhs.isEnabled == rhs.isEnabled &&
            lhs.fireTimeAsString == rhs.fireTimeAsString
    }
}

