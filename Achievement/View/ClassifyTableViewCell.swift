//
//  TableViewCell.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class ClassifyTableViewCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var categoryLbl: UILabel!
    
    
    //--------override-----------------
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    //-------Custom Functions--------------
    
    func configureCell(text:String, color:String){
        categoryLbl.text = text
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
            
        default:
            colorView.backgroundColor = UIColor.gray
            
        }
    }
    
    func decideCategory(colorName:String, categoryName:String, journalIndex:Int){
        UserData.sharedData.journalsToShow[journalIndex].categoryColor = colorName
        UserData.sharedData.journalsToShow[journalIndex].categoryName = categoryName
    }
    //各ジャーナルについてカテゴリー分けされた結果を記憶する。
    
}
