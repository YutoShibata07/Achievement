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

@available(iOS 13.0, *)
@available(iOS 13.0, *)
extension UIViewController{
    func simpleAlert(title:String,msg:String){
    //alertの内容をmsgとして設定することで様々に使い分けることができる。
        let alert  = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func dismissAlert(title:String, msg:String, vc:UIViewController){
        let alert = UIAlertController(title: title, message: msg , preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            vc.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
}


extension String{
    var isNotEmpty :Bool{
        return !isEmpty
    //これはコンピューテッドプロパティ。String型のオブジェクトはisNotEmptyをプロパティとして持つようになる。
    }

}

extension String{
    //本来なら全てUIColorで扱いたいけど、、UIColorはCodableを満たしてないから仕方なく。。。
    func toUIColor() -> UIColor{
        switch self {
        case "レッド":
            return UIColor.red
        case "ブルー":
            return UIColor.blue
        case "グリーン":
            return UIColor.green
        case "パーポｳ":
            return UIColor.purple
        case "ブラック":
            return UIColor.black
        case "ピンク":
            return UIColor.systemPink
        case "ブラウン":
            return UIColor.brown
        case  "イエロー":
            return UIColor.yellow
        default:
            return UIColor.gray
        }
    }
}

extension Journal:Equatable{  //JournalをタイトルでソートするためにEquatableにする。
    public static func ==(lhs:Journal, rhs:Journal) -> Bool{
        return lhs.title == rhs.title
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}


