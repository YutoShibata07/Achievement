//
//  Extension.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/10.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func getToday(format:String = "MM/dd") -> String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    func getTodayDetail(format:String = "yyyy-MM-dd") -> String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
//    今日の３時がデータを入れ替える基準となる。
    func getThree() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone   = TimeZone(identifier: "Asia/Tokyo")
        let three = dateFormatter.date(from: "\(getTodayDetail()) 03:00:00")
        return three ?? Date()
    }
//   比較対象の時刻が今日の３時よりも早いか遅いかを調べる関数
    func compareTime(time:Date) -> Bool!{
        var isBefore:Bool!
        if (time.compare(getThree()) == .orderedAscending){
            isBefore  = true
        }else{
            isBefore = false
        }
        if isBefore == nil{
            print("Wow")
            return true
        }
        return false
        
    }
   
    
}
extension UILabel{
    func getToday(format:String = "MM/dd") -> String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
}
extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
}

class dateLbl:UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        text = getToday()
    }
}


