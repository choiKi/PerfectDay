//
//  MyTableViewCell.swift
//  PerfectDay
//
//  Created by comsoft on 2022/05/13.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var PlanTime: UILabel!
    @IBOutlet weak var PlanName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
