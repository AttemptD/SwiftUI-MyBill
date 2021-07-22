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
    var lineData = [Double]()
    var imagename = "arrow.down.right.and.arrow.up.left"
    var haveData = false
    var isSelect = false
}


class FolderData: ObservableObject {
    
    @Published var folderList = [Folder]()
    @Published var typeChange = "全部"
    
    @Published var selectFolderList = [String]()
    
    var bill = [Model]()
    var lineDatas = [0.0]
    
    init() {
        getFolderBillData()
    }
    
    func refresh() {
        objectWillChange.send()
        self.folderList.removeAll()
        self.getFolderBillData()
        
    }
    
    func transerBilltype(type:String){
        objectWillChange.send()
        
        self.folderList.removeAll()
       
        if type != ""{
            if type == "全部"{
                self.getFolderBillData()
            }else{
                self.getFolderBillData_pay(type: type)
            }
        }else{
            self.getFolderBillData()
        }
         self.getType()
       
    }
    
    func getType()  {
        self.typeChange = userDefault.string(forKey: "type") ?? "全部"
       
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
    
    func select(folder:Folder)  {
        objectWillChange.send()
        
        folder.isSelect.toggle()
        
        if folder.isSelect {
            selectFolderList.append(folder.folderTime)
        }else{
            
            for i in 0..<selectFolderList.count {
              
                if folder.folderTime == selectFolderList[i] {
                    self.selectFolderList.remove(at: i)
                    
                    break
                }
            }
        }
        
        print(selectFolderList)
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
        
        
        
        userDefault.set("全部", forKey: "type")
        
        
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
                
                if data["money"].double! > 0 &&  data["money"].double! <= 1{
                    self.lineDatas.append(data["money"].double!/15)
                }else if data["money"].double! > 1 && data["money"].double! <= 100{
                    self.lineDatas.append(data["money"].double!/150)
                }else if data["money"].double! > 100 && data["money"].double! <= 1000{
                    self.lineDatas.append(data["money"].double!/1500)
                }else if data["money"].double! > 1000 && data["money"].double! <= 10000{
                    self.lineDatas.append(data["money"].double!/15000)
                }else if data["money"].double! > 10000 && data["money"].double! <= 100000{
                    self.lineDatas.append(data["money"].double!/150000)
                }
               
                self.bill.append(bill)
                
            }
            
            folder.folderBill = self.bill
            folder.folderTime = fold.folderTime
            folder.lineData = self.lineDatas
           
            if self.bill.count > 0{
                folder.haveData = true
            }else{
                folder.haveData = false
            }
           
            self.folderList.append(folder)
            self.lineDatas.removeAll()
            self.bill.removeAll()
            self.lineDatas.append(0.0)
        }
    }
    
    func getFolderBillData_pay(type:String)  {
        
        
        
        userDefault.set(type, forKey: "type")
        
        
        let folderdata = RealmDB().getDB().objects(FolderBill.self).sorted(byKeyPath: "folderTime",ascending: false)
        
        for fold in folderdata {
            
            let folder = Folder()
            
            folder.id = self.folderList.count
            
            let json = JSON(getArrayFromJSONString(jsonString: fold.bill))
            
            
            for i in 0..<json.count{
                let data = json[i]
                let bill = Model()
                
                if data["type"].string! == type{
                    
                    bill.id =  self.bill.count
                    bill.blurTime = data["blurTime"].string!
                    bill.type = data["type"].string!
                    bill.money = data["money"].double!
                    bill.time = data["time"].string!
                    bill.doWhat = data["doWhat"].string!
                    
                    if data["money"].double! > 0 &&  data["money"].double! <= 1{
                        self.lineDatas.append(data["money"].double!/15)
                    }else if data["money"].double! > 1 && data["money"].double! <= 100{
                        self.lineDatas.append(data["money"].double!/150)
                    }else if data["money"].double! > 100 && data["money"].double! <= 1000{
                        self.lineDatas.append(data["money"].double!/1500)
                    }else if data["money"].double! > 1000 && data["money"].double! <= 10000{
                        self.lineDatas.append(data["money"].double!/15000)
                    }else if data["money"].double! > 10000 && data["money"].double! <= 100000{
                        self.lineDatas.append(data["money"].double!/150000)
                    }
                    
                    self.bill.append(bill)
                }
            }
            
            folder.folderBill = self.bill
            folder.folderTime = fold.folderTime
            folder.lineData = self.lineDatas
            
            if self.bill.count > 0{
                folder.haveData = true
               
            }else{
                folder.haveData = false
                folder.open = false
            }
            
            self.folderList.append(folder)
            self.lineDatas.removeAll()
            self.bill.removeAll()
            self.lineDatas.append(0.0)
        }
    }
}
