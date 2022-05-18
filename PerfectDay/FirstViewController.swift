//
//  FirstViewController.swift
//  PerfectDay
//
//  Created by comsoft on 2022/05/13.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell
    
        PlanName.text = TestArray[indexPath.row]
        return cell
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "Cell"
    let TestArray: [String] = ["기상", "등교 시작", "하교 시작", "학원 등원", "학원 하원"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}
