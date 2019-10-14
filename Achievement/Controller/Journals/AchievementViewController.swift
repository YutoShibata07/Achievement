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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        journalModel.loadedData()
        tableView.reloadData()
        print("appear!!!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.sharedData.journalsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let achieveCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AchieveTableViewCell{
            achieveCell.configureCell(event: UserData.sharedData.journalsToShow[indexPath.row].title,                  color: UserData.sharedData.journalsToShow[indexPath.row].categoryColor)
            return achieveCell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        journalModel.loadedData()
        let deleteButton:UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            UserData.sharedData.journalsToShow.remove(at: indexPath.row)
            self.journalModel.savedData(UserData.sharedData.journalsToShow)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton]
    }
    
    func updateJournals(){
        journalModel.loadedData()
        self.tableView.reloadData()
    }
    
}
