//
//  TableViewCell.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class ClassifyTableViewCell: UITableViewCell {

    @IBOutlet weak var genreLbl: UILabel!
    //--------override-----------------
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //-------Custom Functions--------------
    
    func configureCell(text:String){
        genreLbl.text = text
    }
    
}
