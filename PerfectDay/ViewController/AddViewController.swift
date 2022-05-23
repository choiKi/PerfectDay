//
//  AddViewController.swift
//  PerfectDay
//
//  Created by comsoft on 2022/05/19.
//
 

import UIKit
import RealmSwift
import Foundation

class AddViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var saveBtn: UIButton!

    let realm = try! Realm()
    let vc = ViewController()
    let timeStringFormatter = DateFormatter()
    let timeIntFormatter = DateFormatter()

    var selectTime: String = ""
    var selectedDay: String = "dd"

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedDateLabel.text = selectedDay
        
        saveBtn.backgroundColor = .link
        saveBtn.layer.cornerRadius = 10

    }
    @IBAction func pressSaveBtn(_ sender: UIButton) {

        saveData()
        vc.tableView?.reloadData()
        navigationController?.popViewController(animated: true)
        
    }

   

    @IBAction func changedDatePicker(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "HH:mm"
        selectTime = formatter.string(from: sender.date)
        print(selectTime)

    }

    func saveData() {

        if titleTextField.text != "" , selectTime != "" {

            let scheduleByDate = ScheduleByDate()
            scheduleByDate.date = selectedDay
            scheduleByDate.title = titleTextField.text!
            scheduleByDate.time = selectTime
            scheduleByDate.success = false

            if realm.objects(ScheduleList.self).isEmpty == true {
                let scheduleListArray = ScheduleList()
                scheduleListArray.scheduleList.append(scheduleByDate)

                try! realm.write{
                    realm.add(scheduleListArray)
                }
            } else {
                try! realm.write {
                            let scheduleListArray = realm.objects(ScheduleList.self)
                            scheduleListArray.first?.scheduleList.append(scheduleByDate)
                        }
            }
        } else {
            alert()
        }
    }

    func alert() {
        let nilAlert = UIAlertController(title: " 계획을 입력해주세요 ",
                                         message: "시간은 설정하셨나요?",
                                         preferredStyle: .alert)
        let onAction = UIAlertAction(title: "알겠습니다", style: .cancel , handler: nil)
        nilAlert.addAction(onAction)
        present(nilAlert, animated: true, completion: nil)

    }
}

 



