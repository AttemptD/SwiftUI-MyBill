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
        
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            
            defaultRealm.add(data,update: .modified)
        }
    }
    
    
    func delete(time : String)  {
        
        
        let bill = self.getDB().objects(Bill.self).filter("time == '\(time)'")
        
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
}

class Bill: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var money = 0.0
    @objc dynamic var type = ""
    @objc dynamic var time = ""
    @objc dynamic var doWhat = ""
    @objc dynamic var blurTime = ""
    
    override static func primaryKey() -> String? {
        return "time"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["tempID"]
    }
}

