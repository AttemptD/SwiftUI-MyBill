//
//  NumberTranser.swift
//  pageView
//
//  Created by Attempt D on 2020/6/29.
//  Copyright © 2020 Frank D. All rights reserved.
//

import Foundation


func transer (value:Double) ->String{
    let num = NSNumber(value: value)
    let numberFormatter = NumberFormatter()
    
    numberFormatter.maximumFractionDigits = 2 //保留小数点后面的2位
    return numberFormatter.string(from: num) ?? ""
    
}

func getArrayFromJSONString(jsonString:String) ->NSArray{
     
    let jsonData:Data = jsonString.data(using: .utf8)!
     
    let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if array != nil {
        return array as! NSArray
    }
    return array as! NSArray
     
}

func getString(time :String ,min:Int,max:Int) -> String{
    
    let index1 = time.index(time.startIndex,offsetBy: min)
    let index2 = time.index(time.startIndex,offsetBy: max)
    
    let sub4 = time[index1..<index2]
    
    return String(sub4)
    
}
