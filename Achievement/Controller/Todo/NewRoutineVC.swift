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
        // Do any additional setup after loading the view.
    }
   
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    @IBAction func cancelBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func dicideBtnClicked(_ sender: Any){
        textToSend = textField.text
        dismiss(animated: true, completion: nil)
        if let textToSend = textToSend{
            routines = addArray(array: routines, phraseToAdd: textToSend)
            savedData(routines)
        }
    }
    
    func addArray(array:[Routines],phraseToAdd:String) ->[Routines]{
        var array = array
        array.append(Routines.init(title: phraseToAdd, doneToday: true, coutinuousRecord: 0))
        return array
    }
    
    func savedData(_ value:[Routines]){
        guard let data = try? JSONEncoder().encode(value) else{return}
        ud.set(data, forKey: "routinesToShow")
        ud.synchronize()
    }
    
}
