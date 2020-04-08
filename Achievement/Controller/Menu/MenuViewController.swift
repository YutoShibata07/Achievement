//
//  MenuViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
import GoogleMobileAds
import StoreKit
import MessageUI
import UserNotifications
import SCLAlertView
import SwiftyDropbox

@available(iOS 13.0, *)
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var othresTableView: UITableView!
    @IBOutlet weak var phraseLabel: UILabel!
    let menuModel = MenuModel()
    var bannerView: GADBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.delegate = self
        settingTableView.tag = 0
        othresTableView.delegate = self
        settingTableView.dataSource = self
        othresTableView.dataSource = self
        othresTableView.tag = 1
        
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-7252408232726748/4859564922"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        phraseLabel.textColor = .black
        settingTableView.layer.cornerRadius = 8
        othresTableView.layer.cornerRadius = 8
        menuModel.checkConnetionToDropbox()
    }
    
    //---------------セルの生成に関して--------------------------
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
                
                cell.configureCell(title: menuModel.setting[indexPath.row],imageName: menuModel.settingImages[indexPath.row])
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                return cell
            }
            return UITableViewCell()
        }else{
            
            if let cell = othresTableView.dequeueReusableCell(withIdentifier: "OthersCell", for: indexPath) as? OthersTableViewCell{
                cell.configureCell(title: menuModel.others[indexPath.row],imageName: menuModel.othersImages[indexPath.row])
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                return cell
            }else{
                return UITableViewCell()
            }
            
        }
        
    }
    
    //-----------------セルの選択時に関して--------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //---------------------バックアップに関する処理----------------------
        if tableView.tag == 0 && indexPath.row == 2{
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Step1.Dropboxと連携する"){
                self.menuModel.signInDropbox(controller: self,completion:{})
            }
            
            alertView.addButton("Step2-a.データを「復元」する") {
                self.menuModel.downloadDropboxFile {
                    let alertView = SCLAlertView(appearance: appearance)
                    alertView.addButton("閉じる", action:{})
                    alertView.showInfo("データの読み込み完了！！", subTitle: "いつも有難うございます",colorStyle: 0x79BF73, colorTextButton: 0x000000)
                    
                }
            }
            alertView.addButton("Step2-b. データを「保存」する") {
                self.menuModel.uploadOutput()
                let alertView = SCLAlertView(appearance: appearance)
                alertView.addButton("閉じる", action:{})
                alertView.showInfo("データの書き込み完了！！", subTitle: "いつも有難うございます",colorStyle: 0x79BF73, colorTextButton: 0x000000)
                
            }
            alertView.addButton("やっぱやめる", action:{
                self.dismiss(animated: true, completion: nil)
            })
            alertView.showEdit("バックアップを行う", subTitle: "⚠️先にDropboxと連携させて下さい⚠️",  colorStyle: 0x79BF73, colorTextButton: 0x000000)
            
    
        }
            
        
        if indexPath.row == 0 && tableView.tag == 1{
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("わかりました"){
                let YOUR_APP_ID = "1486176031"
                let urlString = "itms-apps://itunes.apple.com/jp/app/id\(YOUR_APP_ID)?mt=8&action=write-review"
                if let url = URL(string: urlString) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:])
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            alertView.addButton("また今度") {
                self.dismiss(animated: true, completion: nil)
            }
            alertView.showEdit("レビューを書く", subTitle: "機能向上に役立てせたり、読んで嬉しく思ったりします",  colorStyle: 0x79BF73, colorTextButton: 0x000000)
            
            
        }
        //-----------簡単に星で評価する----------------------
        if indexPath.row == 1 && tableView.tag == 1{
            // レビューページへ遷移
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("わかりました"){
                if #available(iOS 10.3, *) {
                    SKStoreReviewController.requestReview()
                }
                    // iOS 10.3未満の処理
                else {
                    if let url = URL(string: "itms-apps://itunes.apple.com/app/id1486176031?action=write-review") {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:])
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                    
                }
            }
            alertView.addButton("また今度") {
                self.dismiss(animated: true, completion: nil)
            }
            alertView.showEdit("簡単に評価する", subTitle: "10秒だけ時間を下さい",  colorStyle: 0x79BF73, colorTextButton: 0x000000)
        }
        
        
        if tableView.tag == 1 && indexPath.row == 2{
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("わかりました") {
                self.sendMail()
            }
            alertView.addButton("また今度") {
                self.dismiss(animated: true, completion: nil)
            }
            alertView.showEdit("アップデートを行う際に参考にします", subTitle: "率直すぎる意見も大歓迎",colorStyle: 0x79BF73, colorTextButton: 0x000000)
        }
        
        if tableView.tag == 0 && indexPath.row == 1{
            performSegue(withIdentifier:"toQuestionVC",sender:self)
        }
        
        
        if tableView.tag == 0 && indexPath.row == 0{
           performSegue(withIdentifier: "toNotificationSetting", sender: self)
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func selectIdentifier(_ tableView:UITableView) -> String{
        if tableView.tag == 0{
            return "SettingCell"
        }else{
            return "OthersCell"
        }
    }
    
    func makeAlert(title:String,subtitle:String){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.showWait(title, subTitle:subtitle,  colorStyle: 0x79BF73, colorTextButton: 0x000000)
    }
    
    
    
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
       

}



//----------------メール送信に関して-----------------------------
@available(iOS 13.0, *)
extension MenuViewController: MFMailComposeViewControllerDelegate{
    func sendMail(){
           
           guard MFMailComposeViewController.canSendMail() else { return }
           let mailComposeViewController = MFMailComposeViewController()
           mailComposeViewController.mailComposeDelegate = self
           mailComposeViewController.setToRecipients(["yutoappdeveloper07@gmail.com"])
           mailComposeViewController.setSubject("「アウトプット」に関して")
           present(mailComposeViewController, animated: true, completion: nil)
       }
       
       // MARK: - MFMailComposeViewControllerDelegate
       
       func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           switch result {
           case .cancelled:
               print("cancelled")
           case .saved:
               print("saved")
           case .sent:
               print("sent")
           case .failed:
               print("failed")
           @unknown default:
               print("unknown")
           }
           self.dismiss(animated: true, completion: nil)
           
       }
       
    
}

