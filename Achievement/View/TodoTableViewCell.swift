//
//  TodoTableViewCell.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var routineLbl: UILabel!
    @IBOutlet weak var ContentView: UIView!
    let sharedUserData:UserData = UserData.sharedData
    let ud = UserDefaults.standard
    override func awakeFromNib() {
        super.awakeFromNib()
        ContentView.layer.cornerRadius = 10
        ContentView.backgroundColor = UIColor.init(hex: "5EC220")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func doneBtnClicked(_ sender: Any) {
        doneBtn.isEnabled = false
        makeLblDone()
        if let doneIndex = routines.index(where:{$0.title == routineLbl.text}){
            routines[doneIndex].doneToday = true
        }
        sharedUserData.countDoneTask()
        guard let data = try? JSONEncoder().encode(routines) else {return}//データ型として値を保存する。
        ud.set(data, forKey: "routinesToShow")
        ud.synchronize()
    }
    func configureCell(text:String,routine:Routines){
        routineLbl.text = text
        doneBtn.isEnabled = true
        print("セルを作成しました")
        if ((sharedUserData.data.isFirstVisit == false)||( routine.doneToday == true)){
            //既にdoneButtonが押されていた場合はラベルのタイトルに斜線を引く。
            print("Done!")
            makeLblDone()
        }
    
    }
    
    func makeLblDone(){
        doneBtn.isEnabled = false
        if let routineLblText = routineLbl.text{
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: routineLblText)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            self.routineLbl.attributedText = attributeString
            if let doneIndex = routines.index(where:{$0.title == routineLbl.text}){
                routines[doneIndex].doneToday = true
            }
        }
    }
   
    
}
