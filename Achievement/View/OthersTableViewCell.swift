//
//  OthersTableViewCell.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/23.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class OthersTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var othersImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title:String,imageName:String){
        titleLabel.text = title
        self.othersImageView.image = UIImage(named: imageName)
    }

}
