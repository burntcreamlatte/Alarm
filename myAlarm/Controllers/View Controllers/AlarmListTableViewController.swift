//
//  AlarmListTableViewController.swift
//  myAlarm
//
//  Created by Aaron Shackelford on 11/11/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlarmController.sharedInstance.loadFromPersistentStore()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.sharedInstance.myAlarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }
        
        let alarmToDisplay = AlarmController.sharedInstance.myAlarms[indexPath.row]
        cell.updateViews(with: alarmToDisplay)
        cell.cellDelegate = self

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarmToDelete = AlarmController.sharedInstance.myAlarms[indexPath.row]
            AlarmController.sharedInstance.deleteAlarm(alarm: alarmToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //identifier
        if segue.identifier == "cellToDetailVC" {
            
        //index
            if let indexPath = tableView.indexPathForSelectedRow {
                //destination
                guard let destinationVC = segue.destination as? AlarmDetailTableViewController else { return }
                //object ready
                let alarm = AlarmController.sharedInstance.myAlarms[indexPath.row]
                //object sent
                destinationVC.alarmLanding = alarm
            }
        }
    }

}
extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alarm = AlarmController.sharedInstance.myAlarms[indexPath.row]
        AlarmController.sharedInstance.toggleIsOn(for: alarm)
        cell.updateViews(with: alarm)
    }
}
