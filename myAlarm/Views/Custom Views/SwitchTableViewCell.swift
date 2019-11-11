//
//  SwitchTableViewCell.swift
//  myAlarm
//
//  Created by Aaron Shackelford on 11/11/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // MARK: - Actions
    @IBAction func switchValueChanged(_ sender: Any) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
