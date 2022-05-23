//
//  ViewController.swift
//  PerfectDay
//
//  Created by comsoft on 2022/05/02.
//

import UIKit
import FSCalendar
import RealmSwift

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet weak var calendar : FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    // 달력에 선택된 날짜
    @IBOutlet weak var todayLabel: UILabel!
    
    
    
    let identifier = "calendarCell"
    let dateFormatter = DateFormatter()
    
    // 렘 클래스 인스턴스화
    let realm = try! Realm()
    
    // 달력에 선택된 날짜 스트링 변수
    var selectedDay = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.calendar.dataSource = self
        self.calendar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // 달력 뷰 초기세팅
        calendarSetting()
        
        // 어플 첫 실행시에 오늘 날짜 출력
        daySetting()
        
        // 렘 스튜디오 위치 출력
        print(realm.configuration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func addBtnPress(_ sender: UIButton) {
        let addVC = UIStoryboard(name: "AddView", bundle: nil).instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        addVC.selectedDay = todayLabel.text!
        navigationController?.pushViewController(addVC, animated: true)
    }

}

// 테이블뷰 관리
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let scheduleByDate = realm.objects(ScheduleByDate.self)
        let selectedCnt = scheduleByDate.filter("date ='\(selectedDay)'")
        
        if selectedCnt.count == 0 {
            return 0
        }else {
            return selectedCnt.count
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let scheduleListArray = realm.objects(ScheduleList.self)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CalendarTableViewCell
        
        cell.title.text = scheduleListArray.first?.scheduleList.filter("date = '\(selectedDay)'")[indexPath.row].title
        cell.time.text = scheduleListArray.first?.scheduleList.filter("date = '\(selectedDay)'")[indexPath.row].time
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let scheduleListArray = realm.objects(ScheduleList.self)
        
        let editVC = UIStoryboard(name: "EditView", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        
        editVC.paramTitle = (scheduleListArray.first?.scheduleList.filter("date = '\(selectedDay)'")[indexPath.row].title)!
        editVC.paramTime = (scheduleListArray.first?.scheduleList.filter("date = '\(selectedDay)'")[indexPath.row].time)!
        editVC.paramSuccess = (scheduleListArray.first?.scheduleList.filter("date = '\(selectedDay)'")[indexPath.row].success)!
        editVC.selectedDay = todayLabel.text!
        
        navigationController?.pushViewController(editVC, animated: true)
        
    }
    
}

// 캘린더 관리

extension ViewController {
    
    func calendarSetting() {
        calendar.appearance.selectionColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        calendar.appearance.todayColor = UIColor(red: 188/255, green: 224/255, blue: 253/255, alpha: 1)
        calendar.scrollDirection = .vertical
        calendar.appearance.titleWeekendColor = .red
        calendar.appearance.headerDateFormat = "YYYY년 M월"
    }
    func daySetting() {
        dateFormatter.dateFormat = "YY년 MM월 dd일"
        let today = dateFormatter.string(from: Date())
        todayLabel.text = today
    }
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY년 MM월 dd일"
        todayLabel.text = dateFormatter.string(from: date)
        selectedDay = dateFormatter.string(from: date)
        // 달력에 날짜 선택시 테이블뷰 다시 보여주기
        tableView.reloadData()
        
    }
    
}


// 데이터베이스 AddViewControlle에서 추가되는 각 계획
class ScheduleByDate: Object {
    @objc dynamic var date: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var time: String = ""
    @objc dynamic var success: Bool = false
}

// 데이터베이스 위에 각 계획들을 하나의 리스트로 묶어서 관리하게 편하게

class ScheduleList : Object {
    var scheduleList = List<ScheduleByDate>()
}
