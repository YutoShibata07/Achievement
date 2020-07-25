//
//  NotificationSettingViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/11/11.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
import Eureka

class NotificationSettingViewController: FormViewController {
    
    var date:Date!
    let userDefault = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form+++Section("通知の時間")
            <<< TimeRow(""){
                $0.title = "時刻を選択"
                if let temp = self.userDefault.object(forKey: "NotificationTime"){
                    $0.value = temp as! Date
                }
            }.onChange({ (row) in
                self.userDefault.setValue(row.value, forKey: "NotificationTime")
                print(type(of: row.value))
            })
    }

    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
    }
    
    
    
   
   

}
