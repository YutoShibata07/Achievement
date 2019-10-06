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
    @IBOutlet weak var bgView: RoudedView!
    @IBOutlet weak var textField: UITextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        bgView.layer.cornerRadius = 10
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func cancelBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addButtonClicked(_ sender: Any){
        if let textToShow = textField.text{
            UserData.sharedData.journalsToShow.append(Journals(title: textToShow, isToday: true, genre:""))
            savedData(UserData.sharedData.journalsToShow)
        }
        
    }
    
    func savedData(_ value:[Journals]){
        guard let data = try? JSONEncoder().encode(value) else { return }
        ud.set(data, forKey: "JournalsToShow")
        ud.synchronize()
    }
    
    

}