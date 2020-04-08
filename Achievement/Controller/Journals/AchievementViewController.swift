//
//  AchievementViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
import GoogleMobileAds


@available(iOS 13.0, *)
class AchievementViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var praseLabel: UILabel!
    var bannerView: GADBannerView!
    var random:Int!
    var journalModel = JournalModel()
    var displayingJournals = [Journal]()
    var selectedJournalTitle = ""
    
    
    //--------------Override------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 8
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-7252408232726748/4859564922"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        random = Int.random(in: 0...3)
        setCommentLabel(random: 4)
        praseLabel.textColor = .black
        headingLabel.textColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        journalModel.loadedData()
        self.displayingJournals = journalModel.sortDisplayingJournal(journals: UserData.sharedData.journalsToShow, VC:self)
        self.tableView?.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddDetailViewController{
            destination.journalTitle = self.selectedJournalTitle
        }
    }
    
    
    //-------広告の配置に関する関数-----------------
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
   
    
    
//----------------セルの配置に関する関数たち---------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayingJournals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let achieveCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AchieveTableViewCell{
            achieveCell.configureCell(event: displayingJournals[indexPath.row].title,                                           color: displayingJournals[indexPath.row].categoryColor)
        

            return achieveCell
        }
            
        
        return UITableViewCell()
    }
    
    

        
    


    
    //------------セルの削除に関する内容---------------------------------------
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        journalModel.loadedData()
        let deleteButton:UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            
            //UserDataの方で消す対象となるJournalを検索する。Title以外はテキトー。
            let deleteIndex = UserData.sharedData.journalsToShow.index(of: Journal(title: self.displayingJournals[indexPath.row].title, categoryName: "", categorycolor: "", creationDate: "",detail: ""))
            
            
            UserData.sharedData.journalsToShow.remove(at:deleteIndex!)
            self.displayingJournals.remove(at: indexPath.row)
            self.journalModel.savedData(UserData.sharedData.journalsToShow)
            if self.displayingJournals.count == 1{
                tableView.reloadData()
            }else{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedJournalTitle = displayingJournals[indexPath.row].title
        performSegue(withIdentifier: "toDetailSegue", sender: self)
    }
    
    func setCommentLabel(random:Int){
        print(random)
               switch random {
               case 0:
                   praseLabel.text = "思いついたことを何でも気軽にメモしよう"
               case 1:
                   praseLabel.text = "本で知ったちょっとした知識を話せる男になりたい"
               case 2:
                   praseLabel.text = "あ！！この雑学アウトプットに残したやつだ！！！"
               case 3:
                   praseLabel.text = "最後に読んだ本の内容覚えとんのか？こまめに記録！"
               case 4:
                praseLabel.text = "＋ボタンを押して今日のアウトプットを作成しよう"
               default:
                   return
               }
    }
    
}
