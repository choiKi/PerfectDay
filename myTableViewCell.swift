//
//  myTableViewCell.swift
//  PerfectDay
//
//  Created by comsoft on 2022/05/19.
//

import UIKit

class myTableViewCell: UITableViewCell {
    @IBOutlet weak var PlanName: UILabel!
    @IBOutlet weak var PlanTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
