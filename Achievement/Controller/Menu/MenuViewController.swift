//
//  MenuViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var othresTableView: UITableView!
    let menuModel = MenuModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.delegate = self
        settingTableView.tag = 0
        othresTableView.delegate = self
        settingTableView.dataSource = self
        othresTableView.dataSource = self
        othresTableView.tag = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return menuModel.setting.count
        }else{
            return menuModel.others.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectIdentifier(tableView) == "SettingCell"{
            if let cell = settingTableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingTableViewCell{
                
                cell.configureCell(title: menuModel.setting[indexPath.row])
                return cell
            }
            return UITableViewCell()
        }else{
            
            if let cell = othresTableView.dequeueReusableCell(withIdentifier: "OthersCell", for: indexPath) as? OthersTableViewCell{
                cell.configureCell(title: menuModel.others[indexPath.row])
                return cell
            }else{
                return UITableViewCell()
            }
            
        }
        
    }
    
    
    func selectIdentifier(_ tableView:UITableView) -> String{
        if tableView.tag == 0{
            return "SettingCell"
        }else{
            return "OthersCell"
        }
    }
       

}
