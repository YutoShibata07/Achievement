//
//  SelectColorTableViewCell.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class SelectColorTableViewCell: UITableViewCell {
    

    @IBOutlet weak var colorNameLbl: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configureCell(colorName:String, color:UIColor){
        colorNameLbl.text = colorName
        colorView.backgroundColor = color
    }
}
