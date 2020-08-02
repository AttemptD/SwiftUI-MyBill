//
//  FolderBill.swift
//  MyBill
//
//  Created by Attempt D on 2020/7/27.
//  Copyright © 2020 Frank D. All rights reserved.
//

import Foundation
import SwiftyJSON

class Folder: Identifiable {
    var id : Int = 0
    var folderDatas = ""
    var folderTime = ""
    var folderBill = [Model]()
    var open = true
    var imagename = "arrow.down.right.and.arrow.up.left"
    var lineData = [Double]()
}


class FolderData: ObservableObject {
    
    @Published var folderList = [Folder]()
    
    var bill = [Model]()
    var lineData = [0.0]
    
    
    init() {
        getFolderBillData()
    }
    
    func refresh() {
        objectWillChange.send()
        self.folderList.removeAll()
        self.bill.removeAll()
        self.getFolderBillData()
        self.setFoloderBillData()
      
    }
    
    func transerStatus(folder:Folder) {
        objectWillChange.send()
        if folder.open == true{
            
           folder.open = false
            folder.imagename = "arrow.up.left.and.arrow.down.right"
            
        }else{
            folder.open=true
             folder.imagename = "arrow.down.right.and.arrow.up.left"
        }
        
       
    }
    
    func setFoloderBillData()  {
        
        var Json : JSON = []
        
        var blurTime = ""
        
        var blurTimeChild = ""
        
        let AllTime = RealmDB().getDB().objects(Bill.self).sorted(byKeyPath: "time",ascending: false)
        
        for data in AllTime {
            
            blurTime = data.blurTime
            
            let folderBillData = RealmDB().getDB().objects(Bill.self).filter("blurTime == '\(data.blurTime)'")
            
            
            if (blurTime != blurTimeChild){
               
                for i in 0..<folderBillData.count {
                    
                    let foldData = folderBillData[i]
                    
                    blurTimeChild = foldData.blurTime
                    
                    let jsonObject : JSON = [
                        "id":folderBillData.count,
                        "doWhat":foldData.doWhat,
                        "money":foldData.money,
                        "time":foldData.time,
                        "blurTime":String(foldData.time.prefix(11)),
                        "type":foldData.type
                        
                    ]
                    
                    Json.arrayObject?.append(jsonObject)
                    
                   
                }
                
                let folder = Folder()
                
                folder.id = self.folderList.count
                folder.folderDatas = Json.rawString() ?? ""
                folder.folderTime = data.blurTime
                
                RealmDB().insertFolder(fold: folder)
                
                Json.arrayObject?.removeAll()
            }
         
        }
        
    }
    
    func getFolderBillData()  {
        let folderdata = RealmDB().getDB().objects(FolderBill.self).sorted(byKeyPath: "folderTime",ascending: false)
        
        for fold in folderdata {
            
            let folder = Folder()
            
            folder.id = self.folderList.count
            
            let json = JSON(getArrayFromJSONString(jsonString: fold.bill))
            
            
            for i in 0..<json.count{
                let data = json[i]
                let bill = Model()
                
                bill.id = i
                bill.blurTime = data["blurTime"].string!
                bill.type = data["type"].string!
                bill.money = data["money"].double!
                bill.time = data["time"].string!
                bill.doWhat = data["doWhat"].string!
                
                
                self.bill.append(bill)
                
                if data["money"].double! >= 10 && data["money"].double! < 100{
                    self.lineData.append(data["money"].double! / 50)
                }
                
                else if data["money"].double! >= 100 &&  data["money"].double! < 1000  {
                    self.lineData.append(data["money"].double! / 500)
                }
                
                else if data["money"].double! >= 1000 && data["money"].double! < 10000 {
                    self.lineData.append(data["money"].double! / 5000)
                }
                else if data["money"].double! >= 10000 && data["money"].double! < 100000{
                    self.lineData.append(data["money"].double! / 50000)
                }
                
                else if data["money"].double! >= 100000{
                    self.lineData.append(data["money"].double! / 500000)
                }
            }
            
            folder.folderBill = self.bill
            folder.lineData = self.lineData
            folder.folderTime = fold.folderTime
            
            print(self.lineData)
            self.folderList.append(folder)
            
            self.lineData.removeAll()
            self.lineData.append(0.0)
            self.bill.removeAll()
            
        }
    }
}
