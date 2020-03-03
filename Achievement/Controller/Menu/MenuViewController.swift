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
        
        if indexPath.row == 0 && tableView.tag == 1{
            
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
        
        if tableView.tag == 1 && indexPath.row == 1{
            sendMail()
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

