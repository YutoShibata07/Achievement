//
//  NewAchievementVC.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/10.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit


class NewAchievementVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bgView: RoudedView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var phraseLabel: UILabel!
    var dynamicColor:UIColor!
    var newJournal:String = ""
    let ud = UserDefaults.standard
    
    //--------override-------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        phraseLabel.textColor = .black
        titleTextView.delegate = self
        textView.delegate = self
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
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        bgView.layer.cornerRadius = 10
        textView.layer.cornerRadius  = 10
        titleTextView.layer.cornerRadius = 10
        titleTextView.text = "内容"
        titleTextView.textColor = .lightGray
        textView.text = "詳細なメモを追加する"
        textView.textColor = .lightGray
        
    }
    
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "詳細なメモを追加する"{
            textView.text = ""
        }
        if textView.text == "内容"{
            textView.text = ""
        }
        textView.textColor = dynamicColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ClasifyViewController{
            destination.newJournal = self.newJournal
            if textView.text != "詳細なメモを追加する"{
                destination.newDetail = self.textView.text
            }else{
                destination.newDetail = ""
            }
            
        }
    }
    
    

    //-----------IBActions------------------
    @IBAction func cancelBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addButtonClicked(_ sender: Any){
        if let textToShow = titleTextView.text, textToShow.isNotEmpty == true{
//      方針転換。カテゴリを決めた段階で新しくJournalを追加する。
        newJournal = textToShow
        }else{
            if #available(iOS 13.0, *) {
                simpleAlert(title: "エラー", msg: "内容が入力されていません")
                return
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    

}
