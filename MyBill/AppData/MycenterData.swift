//
//  MycenterData.swift
//  MyBill
//
//  Created by Attempt D on 2020/8/13.
//  Copyright © 2020 Frank D. All rights reserved.
//

import Foundation
import UIKit

class MyInfoData:ObservableObject{
    
    @Published var ToMain = false
    @Published var name = ""
   
    @Published var headerIco = Data()
    @Published var background = Data()
    
    init() {
        getMyInfo()
        
    }
   
    func getMyInfo() {
        
      
        let mydata = RealmDB().getDB().objects(PersonInfo.self)
        
        for data in mydata {
           
          
           if data.username != "" {
                self.ToMain = true
            }
         
            self.name = data.username
            
            self.headerIco = data.headerIcon
            self.background = data.mainBackground
        }
      
    }
    
    func getMouthPieData() {
        let mouthPieData = RealmDB().getDB().objects(Bill.self).filter(" blurTime <='\(TimeTools().getDay(value: 0, Timetype: "yyyy年MM月dd日"))' and blurTime >='\(TimeTools().getDay(value: -30, Timetype: "yyyy年MM月dd日"))' ")
        
        
    }
}
