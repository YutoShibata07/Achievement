//
//  ClasifyViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/23.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
import StoreKit



class ClasifyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //--------Variable------------
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var returnBtn: UIButton!
    var newJournal:String = ""
    var categoryModel =  CategoryModel()
    
    
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
            categoryName: UserData.sharedData.categoriesToShow[indexPath.row].name, creationDate: getToday()
        )
        UserData.sharedData.numberOfJournals += 1
        if UserData.sharedData.numberOfJournals == 7{
            categoryModel.makeReview()
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
                journalVC.viewWillAppear(true)
                
                print(journalVC)
            }else {
                
            }
            
        })
    }
    
    @IBAction func returnBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    
}
