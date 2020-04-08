//
//  MenuModel.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/29.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import MessageUI
import SwiftyDropbox

class MenuModel{
    var ud = UserDefaults.standard
    var setting:[String] = ["エモい通知","エモい通知とは","データのバックアップを行う"]
    var others:[String] = ["レビューを書く","簡単に評価する","ご意見・ご要望"]
    var settingImages:[String] = ["通知","question","green_check"]
    var othersImages:[String] = ["star","star","mail"]
    let file = "output.csv"
    func signInDropbox(controller:UIViewController,completion:@escaping()->Void){
        DropboxClientsManager.authorizeFromController(UIApplication.shared, controller: controller, openURL: {(url:URL)-> Void in
            print("ログインしました")
            completion()
            UIApplication.shared.openURL(url)
            
        })
    }
    
    func saveConnectionToDropbox(bool:Bool){
        guard let data = try? JSONEncoder().encode(bool) else{return}
        ud.set(data, forKey:"connectionToDropbox")
        ud.synchronize()
    }
    
    func checkConnetionToDropbox()->Bool{
        if let _ = DropboxClientsManager.authorizedClient{
            return true
        }else {return false}
//        guard let data = ud.data(forKey: "connectionToDropbox"),
//            let connectionToDropbox = try?JSONDecoder().decode(Bool.self, from: data) else{return}
//        UserData.sharedData.connectedToDropbox = connectionToDropbox
//        return
    }
    //----------------------Outputの書き込みと保存----------------------
    func loadJournals(){
        guard let data = ud.data(forKey: "JournalsToShow"),
        let journalsToShow = try? JSONDecoder().decode([Journal].self, from: data) else{return}
        UserData.sharedData.journalsToShow = journalsToShow
        return
    }
    func savedData(_ value:[Journal]){
        guard let data = try? JSONEncoder().encode(value) else{return}
        ud.set(data, forKey: "JournalsToShow")
        ud.synchronize()
    }
    
    //---------------------カテゴリーの書き込みと保存-----------------------
    func loadCategoris() {
        guard let data = ud.data(forKey: "CategoriesToShow"),
            let loadedData = try? JSONDecoder().decode([Category].self, from: data) else {return}
        UserData.sharedData.categoriesToShow = loadedData
        return
    }
    
    func saveCategories(_ value:[Category]){
        guard let data = try? JSONEncoder().encode(value) else { return }
        ud.set(data, forKey: "CategoriesToShow")
        ud.synchronize()
    }
    
       
    func  stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func createCSVFile(fileName:String){
        loadJournals()
        loadCategoris()
        var time = ud.object(forKey: "NotificationTime") as? Date
        let filePath = NSHomeDirectory() + "/Documents/" + fileName + ".csv"
        print(fileName)
        print(filePath)
        var fileStrData:String = ""
        var detailWithoutNewLine = ""//詳細メモの改行を違う文字に入れ替える。
        var titleWithoutComma = ""
        var fileArrData = [[String]]()
        for category in UserData.sharedData.categoriesToShow{
            fileStrData += "\"" + category.name + "\"" + ","
            fileStrData += "\"" + category.color + "\""
            fileStrData += "\n"
        }
        for journal in UserData.sharedData.journalsToShow{
            detailWithoutNewLine = journal.detail?.replacingOccurrences(of: "\n", with: "#$%") ?? ""
            detailWithoutNewLine = detailWithoutNewLine.replacingOccurrences(of: ",", with: "$$$")
            titleWithoutComma = journal.title.replacingOccurrences(of: ",", with: "$$$")
            fileStrData += "\"" + titleWithoutComma + "\"" + ","
            fileStrData += "\"" + journal.creationDate + "\"" + ","
            fileStrData += "\"" + detailWithoutNewLine + "\"" + ","
            fileStrData += "\"" + journal.categoryName + "\"" + ","
            fileStrData += "\"" + journal.categoryColor + "\""
            fileStrData += "\n"
        }
        
        var stringDate:String = stringFromDate(date: UserData.sharedData.notificationTime, format: "HH:mm")
        fileStrData += stringDate
        
        print(fileStrData)
        //document directoryにcsvファイルとして書き込む
        do{
            try fileStrData.write(toFile:filePath,atomically: true, encoding: String.Encoding.utf8)
            print("Success to write the file")
        }catch let error as NSError{
            print("Failture to Write file")
        }
        
    }
    //①Document directoryにcsvファイルを入力する。
    //②そのままDropbox内にexportする。
    func uploadOutput(){
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0].appendingPathComponent(file)
        let exportFilePath = documentsDirectory
        createCSVFile(fileName: "output")
        //携帯端末のDocumentsフォルダにまず書き込んでおく。
        if let client = DropboxClientsManager.authorizedClient{
            print("成功したよ")
            client.files.upload(path: "/output.csv",mode:Files.WriteMode.overwrite, input: exportFilePath).response{
                response, error in
                if let matadata = response{
                    print("Upload file name:\(matadata.name)")
                }else{
                    print(error!)
                }
            }
        }
    }
    
    func downloadDropboxFile(completion:@escaping () -> Void){
        let fileManager = FileManager.default
        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destURL = directoryURL.appendingPathComponent(file)
        let destination:(URL,HTTPURLResponse)-> URL = {temporaryURL,response in
            return destURL
        }
        if let client = DropboxClientsManager.authorizedClient{
            client.files.download(path: "/output.csv",overwrite:true,destination:destination).response { (response, error) in
                self.restore_all_info(fileName: "output")
                if let response = response{
                    let responseMetadata = response.0
                    print(responseMetadata)
                    let fileContents = response.1
                    print(fileContents)
                }else if let error = error{
                    print(error)
                }
            }
        }
        completion()
    }
    
    func restore_all_info(fileName:String){
        let filePath = NSHomeDirectory() + "/Documents/" + fileName + ".csv"
        var csvLines = [String]()
        var journalTitle:String?
        var journalDate:String?
        var journalCategory:String?
        var journalCategoryColor:String?
        var journalDetail:String?
        var categoryColor:String?
        var categoryName:String?
        do{
            var csvString = try String(contentsOfFile:filePath,encoding: String.Encoding.utf8)
            csvString = csvString.replacingOccurrences(of: "\r", with: "\n")
            csvLines = csvString.components(separatedBy: .newlines)
        }catch let error as NSError{
            print("エラー:\(error)")
            return
        }
        for outputData in csvLines{
            var shouldContitue = false
            let factorOfOutput = outputData.components(separatedBy: ",")
            print(factorOfOutput)
            if factorOfOutput.count == 2{
                guard let categoryName = removeDoubleQuataion(string: factorOfOutput[0]),
                    let categoryColor = removeDoubleQuataion(string: factorOfOutput[1]) else{return}
                //既に同じカテゴリーを持っている場合に複製することを防ぐ。
                for category in UserData.sharedData.categoriesToShow {
                    if category.name == categoryName{
                        shouldContitue = true
                    }
                }
                if shouldContitue == true{continue}
                
                UserData.sharedData.categoriesToShow.append(Category.init(name: categoryName, color: categoryColor))
            }else if factorOfOutput.count == 5{
                //------------""マークを除去する--------------------------
                guard var journalTitle = removeDoubleQuataion(string: factorOfOutput[0]),
                let journalCategory = removeDoubleQuataion(string: factorOfOutput[3]),
                let journalCategoryColor = removeDoubleQuataion(string: factorOfOutput[4]),
                let journalDate = removeDoubleQuataion(string: factorOfOutput[1]),
                var journalDetail = removeDoubleQuataion(string: factorOfOutput[2])  else{return}
                journalTitle = journalTitle.replacingOccurrences(of: "$$$", with: ",")
                journalDetail = journalDetail.replacingOccurrences(of: "#$%", with: "\n")
                journalDetail = journalDetail.replacingOccurrences(of: "$$$", with: ",")
                UserData.sharedData.journalsToShow.append(Journal.init(title: journalTitle, categoryName: journalCategory, categorycolor: journalCategoryColor, creationDate: journalDate, detail: journalDetail))
            }
        }
        saveCategories(UserData.sharedData.categoriesToShow)
        savedData(UserData.sharedData.journalsToShow)
    }
    
    func removeDoubleQuataion(string:String) -> String?{
        var stringWithoutDoubleQuatation:String!
        stringWithoutDoubleQuatation = string.replacingOccurrences(of: "\"", with: "")
        return stringWithoutDoubleQuatation
    }

}

