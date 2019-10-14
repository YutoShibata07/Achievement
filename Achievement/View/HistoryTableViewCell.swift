//
//  HistoryTableViewCell.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/12.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(title:String, color:UIColor){
        colorView.backgroundColor = color
        categoryNameLabel.text = title
    }
}
