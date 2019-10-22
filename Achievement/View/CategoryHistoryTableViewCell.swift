//
//  CategoryHistoryTableViewCell.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/14.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class CategoryHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var journalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(journal:String){
        journalLabel.text = journal
    }
}
