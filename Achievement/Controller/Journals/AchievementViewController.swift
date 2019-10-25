//
//  AchievementViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit


class AchievementViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    
    var journalModel = JournalModel()
    var displayingJournals = [Journal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        journalModel.loadedData()
        
        
        //ーーーーーーーーーーここからデータをリセットするかどうかの判断を行うーーーーーーーーーーーーーーーー
        if journalModel.lastVisitTime != nil{
            UserData.sharedData.data.isFirstVisit = compareTime(time: journalModel.lastVisitTime)
            //最終ログインの時間が前の3時よりも昔か後か。前だったらisFirstVisit = Trueとなる。
        }else{ //アプリに訪れたことのないユーザーに対する処理。
            UserData.sharedData.data.isFirstVisit = true
            print("本日初めてのログインです。")
        }
        if UserData.sharedData.data.isFirstVisit == true{
            print("本日初めてのログインなのでデータをリセットします。")
            journalModel.resetData()
            //リセットした状態を保存する。
            journalModel.savedData(UserData.sharedData.journalsToShow)
        }
        
        self.displayingJournals = journalModel.sortDisplayingJournal(journals: UserData.sharedData.journalsToShow, VC:self)
        journalModel.lastVisitTime = Date()//最終ログイン時間を今の時間に設定する。
//        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayingJournals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let achieveCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AchieveTableViewCell{
            achieveCell.configureCell(event: displayingJournals[indexPath.row].title,                                           color: displayingJournals[indexPath.row].categoryColor)
            return achieveCell
        }
        return UITableViewCell()
    }
    
   
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        journalModel.loadedData()
        let deleteButton:UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            
            //UserDataの方で消す対象となるJournalを検索する。Title以外はテキトー。
            let deleteIndex = UserData.sharedData.journalsToShow.index(of: Journal(title: self.displayingJournals[indexPath.row].title, isToday: true, categoryName: "", categorycolor: "", creationDate: ""))
            print(deleteIndex)
            
            UserData.sharedData.journalsToShow.remove(at:deleteIndex!)
            self.displayingJournals.remove(at: indexPath.row)
            self.journalModel.savedData(UserData.sharedData.journalsToShow)
            if self.displayingJournals.count == 1{
                tableView.reloadData()
            }else{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton]
    }
    
    func updateJournals(){
        journalModel.loadedData()
        self.tableView.reloadData()
    }
    
}
