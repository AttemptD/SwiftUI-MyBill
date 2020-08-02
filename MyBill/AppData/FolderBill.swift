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
}


class FolderData: ObservableObject {
    
    @Published var folderList = [Folder]()
    
    @Published var bill = [Model]()
    
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
            }
            
            folder.folderBill = self.bill
            folder.folderTime = fold.folderTime
            
            self.folderList.append(folder)
            
            self.bill.removeAll()
        }
    }
}
