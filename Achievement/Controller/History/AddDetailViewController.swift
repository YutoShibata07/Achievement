//
//  AddDetailViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/19.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
import GoogleMobileAds


class AddDetailViewController: UIViewController, UITextViewDelegate ,UITextFieldDelegate{

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var journalTitle:String!
    var journalDetail = ""
    let journalModel = JournalModel()
    var dynamicColor:UIColor!
    
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        titleTextView.delegate = self
        if #available(iOS 13.0, *){
            dynamicColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .unspecified,
                     .light: return .black
                case .dark: return .white
                }
            }
        }else{
            dynamicColor = .black
        }
        
        titleTextView.textColor = dynamicColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        titleTextView.text = journalTitle
        journalModel.loadedData()
        titleTextView.layer.cornerRadius = 8
        textView.layer.cornerRadius = 8
        let index = UserData.sharedData.journalsToShow.index(of: Journal.init(title: journalTitle, categoryName: "", categorycolor: "", creationDate: "", detail: ""))
        //詳細メモを表示させるメモのインデックスをまず調べる
        if let detail = UserData.sharedData.journalsToShow[index!].detail{
            if detail == ""{
                textView.text = "詳細なメモを残す"
                textView.textColor = .lightGray
            }else{
                self.textView.text = detail
                self.textView.textColor = dynamicColor
            }
            
        }
        view.bringSubviewToFront(textView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.textView.isFirstResponder) {
            self.textView.resignFirstResponder()
        }
        if self.titleTextView.isFirstResponder {
            self.titleTextView.resignFirstResponder()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.textColor = dynamicColor
    }
    
    
    

      
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        var edittedIndex = UserData.sharedData.journalsToShow.index(of: Journal(title: journalTitle,  categoryName: "", categorycolor: "", creationDate: "",detail: ""))
       
    }
    
    
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "詳細なメモを残す"{
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let detail = textView.text , detail.isNotEmpty == true else {
            if #available(iOS 13.0, *) {
                dismissAlert(title: "警告", msg: "詳細メモを消去します", vc: self)
            } else {
                // Fallback on earlier versions
            }
            return
        }
        let index = UserData.sharedData.journalsToShow.index(of: Journal(title: journalTitle,  categoryName: "", categorycolor: "", creationDate: "",detail: ""))
        UserData.sharedData.journalsToShow[index!].detail = detail
        guard let journalTitle = self.titleTextView.text else{
            if #available(iOS 13.0, *) {
                simpleAlert(title: "エラー", msg: "タイトルが入力されていません")
            } else {
                // Fallback on earlier versions
            }
            return
        }
        UserData.sharedData.journalsToShow[index!].title = journalTitle
        journalModel.savedData(UserData.sharedData.journalsToShow)
        dismiss(animated: true, completion: {
            [presentingViewController] () -> Void in
            // 閉じた時に行いたい処理
            presentingViewController?.viewWillAppear(true)
        })
    }
    
    
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

   
}
