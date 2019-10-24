//
//  MacawChartView.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/22.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import Macaw

class MacawChartView:MacawView{
    
    
    
    
    static var lastSevenShows = createWeekData() //一週間の日にちをジャーナルの数を保持させる。
    static var maxValue = getWeeklyJournalsCount(week: getOneWeek()).max()
    static let maxValueLineHeight = 180
    static let lineWidth:Double = 385
    static let maxGraphValue = 10//グラフの上限を１0に定める。10以上は流石にない。。。
    static let dataDivisor = round(Double(maxGraphValue)/Double(maxValueLineHeight) * 1000) / 1000
    static var adjustData:[Double] = lastSevenShows.map({Double($0.viewCount) / dataDivisor})
    static var animations :[Animation] = []
    var graphModel = GraphModel()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(node:MacawChartView.createChart(), coder: aDecoder)
        backgroundColor = UIColor.init(hex: "5EC220", alpha: 1)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    
    private static func createChart() -> Group{
        var items :[Node] = addXAxisItems() + addYAxisItems()
        items.append(createBars())

        return Group(contents: items, place: .identity)
    }



    private static func addYAxisItems() -> [Node]{
        print("maxValue:\(maxValue)")
        let maxLines = 5
        let lineInterval = Double(maxGraphValue / maxLines)
        print("LineInterval\(lineInterval)")
        let yAxisHeight:Double = 200
        let lineSpacing:Double = 36

        var newNodes:[Node] = []

        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * lineSpacing)
            //Yの値を表示するためのライン。全部で5本ある。少しY軸より左側から始めるので x1 = -5
            let valueLine = Line(x1: -5, y1: y, x2: lineWidth, y2: y).stroke(fill:Color.white.with(a: 0.10))
            let valueText = Text(text: "\(Int((Double(i) * lineInterval)))", align: .max, baseline: .mid, place: .move(dx: -5, dy: y))
            valueText.fill = Color.white
            newNodes.append(valueLine)
            newNodes.append(valueText)
        }

        let yAxis = Line(x1:0, y1: 0, x2:0, y2: yAxisHeight).stroke(fill:Color.white.with(a: 0.25))

        newNodes.append(yAxis)

        return newNodes
    }

    private static func addXAxisItems() -> [Node]{
        let chartBaseY:Double = 200
        var newNodes:[Node] = []
        
        for i in 1...adjustData.count {
            let x = (Double(i) * 51.5) //棒グラフの感覚は50
            let valueText = Text(text: lastSevenShows[i - 1].showNumber, align:.max, baseline:.mid, place:.move(dx:x, dy:chartBaseY + 10))//文字はx軸の少し下に置く。
            valueText.fill = Color.white
            newNodes.append(valueText)
        }
        
        let xAxis = Line(x1: 0, y1: chartBaseY, x2: lineWidth, y2: chartBaseY).stroke(fill: Color.white.with(a: 0.5))
        newNodes.append(xAxis)
        return newNodes
    }


    private static func createBars() -> Group{
        let fill = LinearGradient.init(degree: 90, from: Color.black, to: Color.black.with(a: 0.6))
        let items = adjustData.map{ _ in Group()}
        
        animations = items.enumerated().map{(i: Int, item:Group) in
            item.contentsVar.animation(delay:Double(i) * 0.05){ t in
                let height = adjustData[i] * t
                let rect = Rect(x: Double(i) * 50 + 25, y: 200 - height, w: 30, h: height)
                return [rect.fill(with:fill)]
            }
        }
        
        return items.group()
    }



    static func playAimation(){
        animations.combine().play()
    }

    
    //1週間の日にちを取得する。
    private static  func getOneWeek(format:String = "MM/dd") -> [String]{
          let formatter = DateFormatter()
          formatter.dateFormat = format
          var week:[Date] = []
          var stringWeek :[String] = []
          for i in 1...7{
              var j = 7 - i
              week.append(Date(timeIntervalSinceNow: TimeInterval(-j*24*60*60)))
              stringWeek.append(formatter.string(from: week[i - 1] as Date))
          }
          return stringWeek
      }
      
    
    //直近一週間でどれくらいのメモを書いたのかを記録する。
    private static func getWeeklyJournalsCount(week:[String]) -> [Int]{
        GraphModel.loadJournals()
        var updateJournals = UserData.sharedData.journalsToShow
        print(UserData.sharedData.journalsToShow.count)
        var countsInWeek = [0,0,0,0,0,0,0]
        
        for i in 0...6{ //7日前から始めて７日分計算する。　i=0なら７日前。
            for jounral in updateJournals {
                if week[i] == jounral.creationDate{
                    countsInWeek[i] += 1
                }
            }
        }
        return countsInWeek
      }
    
    
    
    
    static func createWeekData() -> [JournalsCount]{
        let oneWeek = self.getOneWeek()
        let weeklyCount:[Int] = getWeeklyJournalsCount(week: oneWeek)
        let one = JournalsCount(showNumber: oneWeek[0], viewCount: weeklyCount[0])
        let two = JournalsCount(showNumber: oneWeek[1], viewCount: weeklyCount[1])
        let three = JournalsCount(showNumber: oneWeek[2], viewCount: weeklyCount[2])
        let four = JournalsCount(showNumber: oneWeek[3], viewCount: weeklyCount[3])
        let five = JournalsCount(showNumber: oneWeek[4], viewCount: weeklyCount[4])
        let six = JournalsCount(showNumber: oneWeek[5], viewCount: weeklyCount[5])
        let seven = JournalsCount(showNumber: oneWeek[6], viewCount: weeklyCount[6])

        return [one, two, three, four, five, six , seven]
    }
    
    
    
    
}


