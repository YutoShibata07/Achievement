//
//  ClasifyViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/23.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class ClasifyViewController: UIViewController,UITabBarDelegate,UITableViewDataSource {
    //--------Variable------------
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let sharedUserData:UserData = UserData.sharedData
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedUserData.data.genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell ＝
    }
    


}
