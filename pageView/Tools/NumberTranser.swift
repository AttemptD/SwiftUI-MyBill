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
