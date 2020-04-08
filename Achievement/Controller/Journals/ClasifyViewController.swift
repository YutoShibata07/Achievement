//
//  ClasifyViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/23.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
import StoreKit
import SCLAlertView



class ClasifyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //--------Variable------------
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var returnBtn: UIButton!
    var newJournal:String = ""
    var categoryModel =  CategoryModel()
    var newDetail:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryModel.loadCategoris()
        return UserData.sharedData.categoriesToShow.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let classifyCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ClassifyTableViewCell{
            categoryModel.loadCategoris()
            classifyCell.configureCell(text: UserData.sharedData.categoriesToShow[indexPath.row].name, color: UserData.sharedData.categoriesToShow[indexPath.row].color)
            return classifyCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        categoryModel.loadCategoris()
        let deleteButton:UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            UserData.sharedData.categoriesToShow.remove(at: indexPath.row)
            self.categoryModel.saveCategories(UserData.sharedData.categoriesToShow)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton]
    }
    
    
    //-------------------カテゴリーの決定時の処理ーーーーーーーーーーーーーーーーーーー
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryModel.loadJournals()
        categoryModel.makeNewJournal(
            title: newJournal, //NewJournalVCから送られてきたnewJournalのタイトル。
            color: UserData.sharedData.categoriesToShow[indexPath.row].color,
            categoryName: UserData.sharedData.categoriesToShow[indexPath.row].name, creationDate: getToday(),detail: newDetail
        )
        
        //-------------------レビューを書かせるための処理------------------
        
        var journalCount = UserData.sharedData.journalsToShow.count
        if journalCount == 1{
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("了解した！") {
                self.dismiss(animated: true, completion: nil)
            }
            
            alertView.showInfo("初アウトプットお疲れ様です！", subTitle: "設定欄から「エモい通知」機能を設定して復習に役立てよう",  colorStyle: 0x79BF73, colorTextButton: 0x000000)
            
        }
        if (journalCount == 5) {
            makeAlertReview()
        }
        
        if journalCount == 17{
            writeReview()
        }
        
        if (journalCount == 35){
            makeAlertReview()
        }
        
        if (journalCount == 78) || (journalCount == 120) {
            writeReview()
        }
        
        
        categoryModel.saveJournals(UserData.sharedData.journalsToShow)  //新たに要素が追加されたjournalsToShowを保存する。
        
        presentingViewController?.presentingViewController!.dismiss(animated: true, completion: {
            [presentingViewController] () -> Void in
            // 閉じた時に行いたい処理
            
            if #available(iOS 13.0, *) {
                guard let journalVC = self.storyboard?.instantiateViewController(identifier: "JournalViewController") as? AchievementViewController else{
                    print("error")
                    return
                }
                journalVC.random = Int.random(in: 0...3)
                journalVC.viewWillAppear(true)
                print(journalVC)
            }else {
                
            }
            
        })
    }
    
    @IBAction func returnBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func makeAlertReview(){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("わかりました"){
            
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
                // iOS 10.3未満の処理
            else {
                if let url = URL(string: "itms-apps://itunes.apple.com/app/id1486176031?action=write-review") {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:])
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
                
            }
        }
        alertView.addButton("また今度") {
            self.dismiss(animated: true, completion: nil)
        }
        alertView.showEdit("簡単に評価する", subTitle: "10秒だけ時間を下さい",  colorStyle: 0x79BF73, colorTextButton: 0x000000)
        
        
    }
    
    func writeReview(){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("わかりました"){
            let YOUR_APP_ID = "1486176031"
            let urlString = "itms-apps://itunes.apple.com/jp/app/id\(YOUR_APP_ID)?mt=8&action=write-review"
            if let url = URL(string: urlString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:])
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        alertView.addButton("また今度") {
            self.dismiss(animated: true, completion: nil)
        }
        alertView.showEdit("レビューを書く", subTitle: "機能向上に役立てせたり、読んで嬉しく思ったりします",  colorStyle: 0x79BF73, colorTextButton: 0x000000)
        
    }
    
    
  
    
}
