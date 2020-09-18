//
//  TimeTools.swift
//  pageView
//
//  Created by Attempt D on 2020/7/10.
//  Copyright © 2020 Frank D. All rights reserved.
//

import Foundation


class TimeTools {
    //date转时间String
    func dataToTime(date:Date,type:String) ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        return dateFormatter.string(from: date)
    }
    
    func getDay(value : Int,Timetype : String) ->String{
        let calendar = Calendar.current
        let twoDaysAgo = calendar.date(byAdding: .day, value: value, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = Timetype
        let date = formatter.string(from: twoDaysAgo)
        return date
    }
    
    func stringConvertDate(string:String) -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    
}
func getweekTime() ->[String] {
    var week = [String]()
    for i in 0 ..< 7{
        if i == 0{
            week.append("今天")
        }else if -i == -1 {
            week.append("昨天")
        }else if -i == -2 {
            week.append("前天")
        }else{
            week.append(TimeTools().getDay(value: -i, Timetype: "MM-dd"))
        }
    }
    return week
}
