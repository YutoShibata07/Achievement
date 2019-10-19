//
//  AddDetailViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/19.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class AddDetailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var journalTitle:String!
    let journalModel = JournalModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textView.layer.cornerRadius = 8
        titleLabel.text = journalTitle
        journalModel.loadedData()
        let index = UserData.sharedData.journalsToShow.index(of: Journal.init(title: journalTitle, isToday: true, categoryName: "", categorycolor: "", creationDate: ""))
        if let detail = UserData.sharedData.journalsToShow[index!].detail{
            textView.text = detail
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.textView.isFirstResponder) {
            self.textView.resignFirstResponder()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "詳細なメモを残す。"{
            textView.text = ""
        }
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let detail = textView.text , detail.isNotEmpty == true else {
            dismissAlert(title: "警告", msg: "詳細メモを消去します", vc: self)
            return
        }
        let index = UserData.sharedData.journalsToShow.index(of: Journal.init(title: journalTitle, isToday: true, categoryName: "", categorycolor: "", creationDate: ""))
        UserData.sharedData.journalsToShow[index!].detail = detail
        
        journalModel.savedData(UserData.sharedData.journalsToShow)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

   
}
