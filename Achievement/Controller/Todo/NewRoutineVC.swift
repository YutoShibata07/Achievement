//
//  NewRoutineVC.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/09.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class NewRoutineVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    var textToSend:String!
    @IBOutlet weak var bgView: UIView!
    let ud = UserDefaults.standard
    @IBOutlet weak var decideBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.layer.cornerRadius = 10
        textField.delegate = self
    }
   
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    @IBAction func cancelBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func dicideBtnClicked(_ sender: Any){
        if let newJournal = textField.text{
            UserData.sharedData.routinesToShow.append(Routines(title: newJournal, doneToday: false, coutinuousRecord: 0))
            savedData(UserData.sharedData.routinesToShow)
        }
        dismiss(animated: true, completion: {
                [presentingViewController] () -> Void in
                    // 閉じた時に行いたい処理
                    presentingViewController?.viewWillAppear(true)
        })
    }
    
    
    func savedData(_ value:[Routines]){
        guard let data = try? JSONEncoder().encode(value) else{return}
        ud.set(data, forKey: "routinesToShow")
        ud.synchronize()
    }
    
}
