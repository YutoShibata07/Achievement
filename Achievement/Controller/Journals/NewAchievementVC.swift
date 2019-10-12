//
//  NewAchievementVC.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/10.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class NewAchievementVC: UIViewController,UITextFieldDelegate {
    let ud = UserDefaults.standard
    var newJournal:String = ""
    @IBOutlet weak var bgView: RoudedView!
    @IBOutlet weak var textField: UITextField!
    
    //--------override-------------------------
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
           bgView.layer.cornerRadius = 10
       }
       override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
       }
    
    //---------Custom Functions----------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }

    @IBAction func cancelBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addButtonClicked(_ sender: Any){
        if let textToShow = textField.text{
//      UserData.sharedData.journalsToShow.append(Journals.init(title: textToShow, isToday: true,            categoryName: "", categorycolor: "red"))
//      savedData(UserData.sharedData.journalsToShow)
//      方針転換。カテゴリを決めた段階で新しくJournalを追加する。
        newJournal = textToShow
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ClasifyViewController{
            destination.newJournal = self.newJournal
        }
    }

}
