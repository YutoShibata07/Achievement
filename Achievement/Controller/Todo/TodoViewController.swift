//
//  TodoViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
class TodoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var todoModel = TodoModel()
    
//    最後にこのアプリを使った時間。午前３時と比較してデータを更新するために使用する。
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if todoModel.lastVisitTime != nil{
            UserData.sharedData.data.isFirstVisit = compareTime(time: todoModel.lastVisitTime)
            //最終ログインの時間が前の3時よりも昔か後か。
        }else{
            UserData.sharedData.data.isFirstVisit = true
            print("本日初めてのログインです。")
        }
        if UserData.sharedData.data.isFirstVisit == true{
            print("本日初めてのログインなのでデータをリセットします。")
            todoModel.resetData()
            todoModel.routines.remove(at: 0)//3日前のデータを消す。
            UserData.sharedData.data.recentCount.append(0)
        }
        todoModel.lastVisitTime = Date()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        todoModel.lastVisitTime = Date()
        todoModel.loadRoutines()
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.sharedData.routinesToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "routineCell", for: indexPath) as? TodoTableViewCell{
            cell.configureCell(text: todoModel.routines[indexPath.row].title,routine: todoModel.routines[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton:UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            self.todoModel.routines.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton]
    }
   
   
    

}
