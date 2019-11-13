//
//  AchieveTableViewCell.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class AchieveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var colorView: RoudedView!
    @IBOutlet weak var achieveLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ContentView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(event:String, color :String){
        achieveLbl.text = event
        switch color {
        case "レッド":
            colorView.backgroundColor = UIColor.red
        case "ブルー":
            colorView.backgroundColor = UIColor.blue
        case "ブラック":
            colorView.backgroundColor = UIColor.black
        case "ピンク":
            colorView.backgroundColor = UIColor.systemPink
        case "ブラウン":
            colorView.backgroundColor = UIColor.brown
        case "パーポｳ":
            colorView.backgroundColor = UIColor.purple
        case "イエロー":
            colorView.backgroundColor = UIColor.yellow
        case "シアン":
            colorView.backgroundColor = UIColor.cyan
        case "オレンジ":
            colorView.backgroundColor = UIColor.orange
            
        default:
            colorView.backgroundColor = UIColor.gray
        }
    }

}
