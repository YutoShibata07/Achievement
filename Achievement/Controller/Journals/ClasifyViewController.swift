//
//  ClasifyViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/23.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class ClasifyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //--------Variable------------
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var newJournal:String = ""
    
    @IBOutlet weak var returnBtn: UIButton!
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryModel.loadCategoris()
        return UserData.sharedData.categoriesToShow.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let classifyCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ClassifyTableViewCell{
            categoryModel.loadCategoris()
            classifyCell.configureCell(text: UserData.sharedData.categoriesToShow[indexPath.row].name, color: UserData.sharedData.categoriesToShow[indexPath.row].color)
            //カテゴリ名とカラーを表示させる。ここまでは上手くいってる。
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
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryModel.makeNewJournal(
            title: newJournal, //NewJournalVCから送られてきたnewJournalのタイトル。
            color: UserData.sharedData.categoriesToShow[indexPath.row].color,
            categoryName: UserData.sharedData.categoriesToShow[indexPath.row].name, creationDate: getToday()
        )
        categoryModel.saveJournals(UserData.sharedData.journalsToShow)  //新たに要素が追加されたjournalsToShowを保存する。
        
        guard let journalVC = self.presentingViewController else{
            return
            
        } //二つ前のviewControllerを取得しておく。
        
        presentingViewController?.presentingViewController!.dismiss(animated: true, completion: {
            [presentingViewController] () -> Void in
            // 閉じた時に行いたい処理
            journalVC.viewWillAppear(true)
           // journalVC.viewWillDisappear(true)//この行が他のVCを開いてもViewWillAppearが呼ばれない諸悪の根源。
        })
    }
    
    @IBAction func returnBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    
}
