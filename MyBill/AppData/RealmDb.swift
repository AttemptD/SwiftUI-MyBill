//
//  RealmDb.swift
//  pageView
//
//  Created by Attempt D on 2020/6/29.
//  Copyright © 2020 Frank D. All rights reserved.
//

import Combine
import Foundation
import RealmSwift


class RealmDB {
    
    func getDB() -> Realm {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/MoneyR.realm")
        
        
        //print(dbPath)
        /// 传入路径会自动创建数据库
        let defaultRealm = try! Realm(fileURL: URL.init(string: dbPath)!)
        
        return defaultRealm
    }
    
    func insert(model:Model)  {
        
        let data = Bill()
        data.money = model.money
        data.doWhat = model.doWhat
        data.time = model.time
        data.type = model.type
        data.blurTime = model.blurTime
        data.blurMouth = model.blurMouth
        
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            
            defaultRealm.add(data,update: .modified)
        }
    }
    
    //删除
    func delete(time : String)  {
        
        
        let bill = self.getDB().objects(Bill.self).filter("time == '\(time)'")
        
        let defaultRealm = self.getDB()
        
        try! defaultRealm.write {
            
            defaultRealm.delete(bill)
        }
        
    }
    
    func deleteBuleTime(time : String)  {
        let bill = self.getDB().objects(Bill.self).filter("blurTime == '\(time)'")
        
        let defaultRealm = self.getDB()
        
        try! defaultRealm.write {
            
            defaultRealm.delete(bill)
        }
    }
    //删除文件夹形式
    func deleteFolder(time : String)  {
        
        
        let bill = self.getDB().objects(FolderBill.self).filter("folderTime == '\(time)'")
        
        let defaultRealm = self.getDB()
        
        try! defaultRealm.write {
            
            defaultRealm.delete(bill)
        }
        
    }
    
    //更新
    func update(model:Model)  {
        
        let data = Bill()
        data.money = model.money
        data.doWhat = model.doWhat
        data.time = model.time
        data.type = model.type
        data.blurTime = model.blurTime
        
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            
            defaultRealm.create(Bill.self, value: data, update: .modified)
        }
    }
    
    
    func insertFolder(fold:Folder)  {
        let folderBill = FolderBill()
        folderBill.folderTime = fold.folderTime
        folderBill.bill = fold.folderDatas
        
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            
            defaultRealm.create(FolderBill.self,value: folderBill,update: .modified)
        }
    }
    
    func insertMyInfo(header:Data,background:Data,name:String) {
        
        let personInfo = PersonInfo()
        personInfo.headerIcon = header
        personInfo.mainBackground = background
        personInfo.username = name
        
        
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            
            defaultRealm.add(personInfo,update: .modified)
        }
        
    }
    
}

class Bill: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var money = 0.0
    @objc dynamic var type = ""
    @objc dynamic var time = ""
    @objc dynamic var doWhat = ""
    @objc dynamic var blurTime = ""
    @objc dynamic var blurMouth = ""
    
    override static func primaryKey() -> String? {
        return "time"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["tempID"]
    }
}

class FolderBill :Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var folderTime = ""
    @objc dynamic var bill = ""
    
    override static func primaryKey() -> String? {
        return "folderTime"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["tempID"]
    }
    
    
    
}

class PersonInfo: Object {
    @objc dynamic var username = ""
   
    @objc dynamic var headerIcon = Data()
    @objc dynamic var mainBackground = Data()
    
    override static func primaryKey() -> String? {
        return "username"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["tempID"]
    }
    
}

