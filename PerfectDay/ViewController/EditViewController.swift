//
//  EditViewController.swift
//  PerfectDay
//
//  Created by comsoft on 2022/05/19.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {

    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var editDatePicker: UIDatePicker!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn : UIButton!

    var paramDate = 0
    var paramTitle = ""
    var paramTime = ""
    var paramSuccess: Bool = false
    var selectedDay = ""
    var selectTime = ""

    let realm = try! Realm()
    let vc = ViewController()

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.

        editTextField.text = paramTitle
        selectTime = paramTime
        selectedDateLabel.text = selectedDay
        print(paramTime)
        print(selectTime)
        
        buttonSetting()

    }

    @IBAction func changedDatePicker(_ sender: UIDatePicker) {

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "HH:mm"
        selectTime = formatter.string(from: sender.date)
        print(selectTime)

    }

    @IBAction func pressDeleteBtn(_ sender: UIButton) {

        let scheduleByDate = realm.objects(ScheduleByDate.self)
        let deleteTitle = scheduleByDate.filter("title == '\(paramTitle)'")
        let deleteTime = scheduleByDate.filter("time == '\(paramTime)'")
        // let deleteSuccess = scheduleByDate.filter("success == '\(paramSuccess)'"

        if deleteTitle.count != 1 {
            print("oops")
        }

        try! realm.write{
            realm.delete(deleteTitle)
            realm.delete(deleteTime)
            //realm.delete(deleteSuccess)
        }

        navigationController?.popViewController(animated: true)
        vc.tableView?.reloadData()

    }

    

    @IBAction func pressEditButton(_ sender: UIButton) {
        
        let scheduleByDate = realm.objects(ScheduleByDate.self)
        let updateScheduleTitle = scheduleByDate.filter("title =='\(paramTitle)' && date =='\(selectedDay)'")
        let updateScheduleTime = scheduleByDate.filter("time =='\(paramTime)' && date =='\(selectedDay)'")
        
        if editTextField.text != "" {
            try! realm.write{
                updateScheduleTitle.first?.title = editTextField.text!
                updateScheduleTime.first?.time = selectTime
            }
        }else {
            alert()
        }
        navigationController?.popViewController(animated: true)
        vc.tableView?.reloadData()

    }

    

    func alert() {

        let nilAlert = UIAlertController(title: " ????????? ?????????????????? ",
                                         message: "",
                                         preferredStyle: .alert)
        let onAction = UIAlertAction(title: "???, ???????????????.", style: .cancel , handler: nil)
        nilAlert.addAction(onAction)
        present(nilAlert, animated: true, completion: nil)

    }
    
    func buttonSetting() {
        
        editBtn.backgroundColor = .link
        editBtn.layer.cornerRadius = 10
        deleteBtn.backgroundColor = .systemRed
        deleteBtn.layer.cornerRadius = 10
    }
}
