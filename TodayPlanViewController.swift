//
//  FirstViewController.swift
//  PerfectDay
//
//  Created by comsoft on 2022/05/13.
//

import UIKit

//테이블뷰 작동을 확인하기 위한 배열
let TestArray: [String] = ["기상", "등교 시작", "하교 시작", "수업 정리"]
let Time: [String] = ["07:30", "08:30", "17:00", "20:00"]

class TodayPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // 세션의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TestArray.count
    }
    // 테이블 뷰 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myTableViewCell
        // 테이블 뷰 작동을 확인하기 위한 작업 - 계획 데이터 입력하는 부분
        cell.PlanName.text = TestArray[indexPath.row]
        cell.PlanTime.text = Time[indexPath.row]
        return cell
    }
    
    // 테이블 뷰 아웃렛
    @IBOutlet weak var tableView: UITableView!
    
    // 날짜 받아오는 레이블
    @IBOutlet weak var Date: UILabel!
    // 오늘 날짜를 받아오는 메서드
    func makeDateString() -> String {
        let x = Calendar.current.date(byAdding: .day, value: 0, to: Foundation.Date())! // 초기 날짜를 세팅하는 Calendar 함수
        let formatter = DateFormatter()             // Date 포맷 객체 선언
        formatter.locale = Locale(identifier: "Ko") // Date 포맷 타입 지정
        formatter.dateFormat = "yyyy.MM.dd (E)"     // 포맷된 형식 문자열 반환 형식
        let day = formatter.string(from: x)         // day 변수에 초기화
        return day
    }
    
    // 앱 실행시 초기화
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        Date.text = makeDateString()
    }
}
