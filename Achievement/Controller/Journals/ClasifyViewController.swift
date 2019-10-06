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
    var selectedGenre:String = ""
    @IBOutlet weak var returnBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.sharedData.genresToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let classifyCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ClassifyTableViewCell{
            classifyCell.configureCell(text: UserData.sharedData.genresToShow[indexPath.row])
            return classifyCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGenre = UserData.sharedData.genresToShow[indexPath.row]
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func returnBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
