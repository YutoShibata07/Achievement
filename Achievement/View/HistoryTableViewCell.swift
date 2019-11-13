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
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorView: UIView!
    var historyModel = HistoryModel()
    var journalsWithDate = [String]()
    var journalsReversed = [Journal]()
    var notDate:Bool! //日付を表示していなければスペースを作る。
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(title:String, color:UIColor){
        self.backgroundColor = .clear
        widthConstraint.constant = 27.5
        colorView.backgroundColor = color
        categoryNameLabel.text = title
    }
    
   
    
    func configureDateCell(journal:DateMixedJournal){
        let colorIndex = UserData.sharedData.journalsToShow.index(of:Journal.init(title: journal.title, isToday: true, categoryName: "", categorycolor: "", creationDate: ""))
        colorView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        
        if notDate == true{
            self.backgroundColor = UserData.sharedData.journalsToShow[colorIndex!].categoryColor.toUIColor().withAlphaComponent(0.04)
        }else {
            self.backgroundColor = UIColor.clear
        }
        
        if self.notDate == true{
            widthConstraint.constant = 20
        }else{
            widthConstraint.constant = 0
        }
        categoryNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        categoryNameLabel.text = journal.title
    }
}
