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
    @IBOutlet weak var decideBtn: UIButton!
    var todoModel = TodoModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.layer.cornerRadius = 10
        textField.delegate = self
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func dicideBtnClicked(_ sender: Any){
        todoModel.loadRoutines()
        if let newTodo = textField.text{
            UserData.sharedData.routinesToShow.append(Routines(title: newTodo, doneToday: false, coutinuousRecord: 0))
        }
        todoModel.savedData(UserData.sharedData.routinesToShow)
        guard let todoVC = self.presentingViewController else{return}
        dismiss(animated: true, completion: {
            [presentingViewController] () -> Void in
            // 閉じた時に行いたい処理
            todoVC.viewWillAppear(true)
            print("viewWillAppearにしたよ")
            todoVC.viewDidDisappear(true)
        })
    }
    
}
