//
//  AlarmDetailTableViewController.swift
//  myAlarm
//
//  Created by Aaron Shackelford on 11/11/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    
    var alarmLanding: Alarm? {
        didSet {
            updateViews()
        }
    }
    var alarmIsOn: Bool = true {
        didSet {
            updateEnableButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    
    // MARK: - Actions
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsOn.toggle()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        let date = datePicker.date
        guard let name = alarmNameTextField.text, name.isEmpty == false else { return }
        if let alarm = alarmLanding {
            AlarmController.sharedInstance.updateAlarm(alarm: alarm, fireDate: date, name: name, isEnabled: alarmIsOn)
        } else {
            AlarmController.sharedInstance.addNewAlarm(fireDate: date, name: name, isEnabled: alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateEnableButton() {
        if alarmIsOn {
            enableButton.setTitle("Disable", for: .normal)
            enableButton.tintColor = UIColor.red
            enableButton.layer.backgroundColor = UIColor.white.cgColor
        } else {
            enableButton.setTitle("Enable", for: .normal)
            enableButton.tintColor = UIColor.white
            enableButton.layer.backgroundColor = UIColor.red.cgColor
        }
    }

    func updateViews() {
        loadViewIfNeeded()
        datePicker.date = Date()
        alarmNameTextField.text = ""
        updateEnableButton()
        guard let alarm = alarmLanding else { return }
        alarmNameTextField.text = alarm.name
        //setting alarmIsOn to true with updateViews()
        alarmIsOn = alarm.isEnabled
    }
}
