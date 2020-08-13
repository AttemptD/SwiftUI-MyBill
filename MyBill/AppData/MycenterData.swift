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
    @Published var sex = ""
    @Published var headerIco = Data()
    @Published var background = Data()
    
    init() {
        getMyInfo()
    }
   
    func getMyInfo() {
        let imageTranser = ImageTranser()
        let mydata = RealmDB().getDB().object(ofType: PersonInfo.self, forPrimaryKey: "username");
        
        print(mydata?.username)
        if mydata?.username != nil{
            self.ToMain = true
        }
        self.name = mydata?.username ?? "请设置用户名"
        self.sex = mydata?.sex ?? "请设置性别"
        self.headerIco = mydata?.headerIcon ?? imageTranser.ImageToData(image: UIImage(named: "MyImageBack")!)
        self.background = mydata?.mainBackground ?? imageTranser.ImageToData(image: UIImage(named: "background")!)
        
    }
}
