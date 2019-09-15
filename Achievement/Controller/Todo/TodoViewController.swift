//
//  TodoViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
var routines = [Routines]()
class TodoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let ud = UserDefaults.standard
    private var lastVisitTime:Date!
//    最後にこのアプリを使った時間。午前３時と比較してデータを更新するために使用する。
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if lastVisitTime != nil{
            print("ohh")
            isFirstVisit = compareTime(time: lastVisitTime)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        lastVisitTime = Date()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        if let loadedRoutines = loadRoutines(){
          routines = loadRoutines()!
        }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(routines.count)
        return routines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "routineCell", for: indexPath) as? TodoTableViewCell{
            cell.configureCell(text: routines[indexPath.row].title)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton:UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            routines.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton]
    }
   
    func loadRoutines() ->[Routines]?{
        guard let data = ud.data(forKey: "routinesToShow"),
            let loadedData = try? JSONDecoder().decode([Routines].self, from: data) else {return nil}
        return loadedData
    }

}
