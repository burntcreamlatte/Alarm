//
//  SwitchTableViewCell.swift
//  myAlarm
//
//  Created by Aaron Shackelford on 11/11/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    weak var cellDelegate: SwitchTableViewCellDelegate?
    
    var alarmLanding: Alarm? {
        didSet {
            if let alarm = alarmLanding {
                updateViews(with: alarm)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Actions
    @IBAction func switchValueChanged(_ sender: Any) {
        cellDelegate?.switchCellSwitchValueChanged(cell: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateViews(with alarm: Alarm) {
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.isEnabled = alarm.isEnabled
    }
}// End of class
