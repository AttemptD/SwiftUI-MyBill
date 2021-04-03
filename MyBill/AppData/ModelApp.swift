//
//  ModelApp.swift
//  pageView
//
//  Created by Attempt D on 2020/6/29.
//  Copyright © 2020 Frank D. All rights reserved.
//

import Foundation
import Combine

class Model: Identifiable {
    var id: Int = 0
    var money = 0.0
    var type = ""
    var time = ""
    var blurTime = ""
    var blurMouth = ""
    var doWhat = ""
    var left = false
    var lastOne = false
    
    
}

class AppData: ObservableObject {
    
    @Published var BillDatas = [Model]()
    
    @Published var AllMony = ""
    @Published var EaringMoney = ""
    @Published var PayMoney = ""
    
    @Published var TodayBill = [Model]()
    
    @Published var TodayPay : Double = 0
    @Published var TodayEarning : Double = 0
    
    @Published var Bill_ten = [Model]()
    @Published var weekData = [Double]()
    @Published var mouthData = [Double]()
    @Published var mouthEarnData = [Double]()
    
    
    init() {
        getTodayAllBills()
        getTodayPay_Earn()
        getAllBill_Ten()
        getWeekData()
        getMouthData()
        getMouthEarnData()
    }
    
    //及时数据更新
    func NowData(time:String,money:Double,type:String,doWhat:String) {
        let billData = Model()
        billData.id = self.TodayBill.count
        billData.doWhat = doWhat
        billData.type = type
        billData.money = money
        billData.time = time
        billData.blurTime = String(time.prefix(11))
        
        if String(time.prefix(11)) == "\(TimeTools().getDay(value: 0, Timetype: "yyyy年MM月dd日"))"{
            self.TodayBill.append(billData)
        }
    }
    
    
    
    func refreshData() {
        
        objectWillChange.send()
        
        
        self.TodayBill.removeAll()
        self.Bill_ten.removeAll()
        
        self.getTodayAllBills()
        self.getTodayPay_Earn()
        self.getAllBill_Ten()
        
        
    }
    
    func setBillData(time:String,money:Double,type:String,doWhat:String){
        
        let billData = Model()
        billData.doWhat = doWhat
        billData.type = type
        billData.money = money
        billData.time = time
        billData.blurTime = String(time.prefix(11))
        billData.blurMouth = String(time.prefix(8))
      
        RealmDB().insert(model: billData)
    }
    
    func updataBillData(time:String,money:Double,type:String,doWhat:String)  {
        let billData = Model()
        billData.doWhat = doWhat
        billData.type = type
        billData.money = money
        billData.time = time
        billData.blurTime = String(time.prefix(11))
        billData.blurMouth = String(time.prefix(8))
        RealmDB().update(model: billData)
    }
    
    //所有账单
    func getBillData() {
        
        let bill = RealmDB().getDB().objects(Bill.self).sorted(byKeyPath: "time",ascending: false)
        
        for Bills in bill{
            
            let billData = Model()
            billData.id = self.BillDatas.count
            billData.doWhat = Bills.doWhat
            billData.money = Bills.money
            billData.type = Bills.type
            billData.time = Bills.time
            billData.blurTime = Bills.blurTime
            billData.blurMouth = Bills.blurMouth
          
            self.BillDatas.append(billData)
        }
        
        
    }
    
    func getMyCenterData(){
        
        let earn : Double = RealmDB().getDB().objects(Bill.self).filter(" type == '收入'").sum(ofProperty: "money")
        let payout: Double = RealmDB().getDB().objects(Bill.self).filter(" type == '支出' ").sum(ofProperty: "money")
        
        self.AllMony = transer(value: earn - payout)
        self.EaringMoney = transer(value: earn)
        self.PayMoney = transer(value: payout)
        
        getWeekData()
        getMouthData()
        getMouthEarnData()
    }
    
    //今天的账单
    func getTodayAllBills() {
        
        let todayBill = RealmDB().getDB().objects(Bill.self).filter(" blurTime == '\(TimeTools().getDay(value : 0,Timetype : "yyyy年MM月dd日"))' ").sorted(byKeyPath: "time", ascending: true)
        
        for today in todayBill{
            let todayData = Model()
            todayData.id = self.TodayBill.count
            todayData.doWhat = today.doWhat
            todayData.money = today.money
            todayData.type = today.type
            todayData.time = today.time
            
            if  self.TodayBill.count == todayBill.count-1{
                todayData.lastOne = true
            }
            
            if Double(self.TodayBill.count).truncatingRemainder(dividingBy: 2) == 0{
                todayData.left = true
            }else{
                todayData.left = false
            }
            
            todayData.blurTime = String(today.time.prefix(11))
            
            self.TodayBill.append(todayData)
        }
    }
    
    //今天的总收入/支出数据
    func getTodayPay_Earn()  {
        let TodayPayOut : Double = RealmDB().getDB().objects(Bill.self).filter(" blurTime == '\(TimeTools().getDay(value : 0,Timetype : "yyyy年MM月dd日"))' AND type == '支出' ").sum(ofProperty: "money")
        
        self.TodayPay = TodayPayOut
        
        let TodayEarn : Double = RealmDB().getDB().objects(Bill.self).filter(" blurTime == '\(TimeTools().getDay(value : 0,Timetype : "yyyy年MM月dd日"))' AND type == '收入' ").sum(ofProperty: "money")
        
        self.TodayEarning = TodayEarn
    }
    
    //限制查询
    func getAllBill_Ten() {
        let bill = RealmDB().getDB().objects(Bill.self).sorted(byKeyPath: "time",ascending: false)
        
        
        if bill.count > 5 {
            for i in 0 ..< 6{
                let billData = Model()
                let bill_ten = bill[i]
                
                
                billData.id = self.Bill_ten.count
                billData.doWhat = bill_ten.doWhat
                billData.money = bill_ten.money
                billData.type = bill_ten.type
                billData.time = bill_ten.time
                billData.blurTime = bill_ten.blurTime
                billData.blurMouth = bill_ten.blurMouth
                
                if Double(self.Bill_ten.count).truncatingRemainder(dividingBy: 2) == 0{
                    billData.left = true
                }else{
                    billData.left = false
                }
                
                if i == 5{
                    billData.lastOne = true
                }
                self.Bill_ten.append(billData)
            }
        }else{
            for Bills in bill{
                
                let billData = Model()
                billData.id = self.Bill_ten.count
                billData.doWhat = Bills.doWhat
                billData.money = Bills.money
                billData.type = Bills.type
                billData.time = Bills.time
                billData.blurTime = String(Bills.time.prefix(11))
                if Double(self.Bill_ten.count).truncatingRemainder(dividingBy: 2) == 0{
                    billData.left = true
                }else{
                    billData.left = false
                }
                
                if self.Bill_ten.count == bill.count - 1{
                    billData.lastOne = true
                }
                
                
                self.Bill_ten.append(billData)
                
            }
        }
    }
    
    func getWeekData()  {
        objectWillChange.send()
        self.weekData.removeAll()
        
        for i in 0 ..< 7 {
            
            let bill :Double = RealmDB().getDB().objects(Bill.self)
                .filter("blurTime == '\(TimeTools().getDay(value: -i, Timetype: "yyyy年MM月dd日"))' AND type == '支出' ")
                .sum(ofProperty: "money")

            
            if bill > 0 &&  bill <= 1{
                self.weekData.append(bill/15)
            }else if bill > 1 && bill <= 100{
                self.weekData.append(bill/150)
            }else if bill > 100 && bill <= 1000{
                self.weekData.append(bill/1500)
            }else if bill > 1000 && bill <= 10000{
                self.weekData.append(bill/15000)
            }else if bill > 10000 && bill <= 100000{
                self.weekData.append(bill/150000)
            }else if bill == 0{
                self.weekData.append(0)
            }
            
           
         
        }
      
    }
    
    func getMouthData()  {
        
        objectWillChange.send()
        
        self.mouthData.removeAll()
        
        for i in 0 ..< 7 {
            
            let bill :Double = RealmDB().getDB().objects(Bill.self)
                .filter("blurMouth == '\(TimeTools().getMouth(value: -i, Timetype: "yyyy年MM月"))' AND type == '支出' ")
                .sum(ofProperty: "money")
            
           
            
            
            if bill > 0 &&  bill <= 1{
                self.mouthData.append(bill/15)
            }else if bill > 1 && bill <= 100{
                self.mouthData.append(bill/150)
            }else if bill > 100 && bill <= 1000{
                self.mouthData.append(bill/1500)
            }else if bill > 1000 && bill <= 10000{
                self.mouthData.append(bill/15000)
            }else if bill > 10000 && bill <= 100000{
                self.mouthData.append(bill/150000)
            }else if bill == 0{
                self.mouthData.append(0)
            }
            
           
         
        }
      
    }
    
    
    func getMouthEarnData()  {
        
        objectWillChange.send()
        
        self.mouthEarnData.removeAll()
        
        for i in 0 ..< 7 {
            
            let bill :Double = RealmDB().getDB().objects(Bill.self)
                .filter("blurMouth == '\(TimeTools().getMouth(value: -i, Timetype: "yyyy年MM月"))' AND type == '收入' ")
                .sum(ofProperty: "money")
            
           
            
            
            if bill > 0 &&  bill <= 1{
                self.mouthEarnData.append(bill/15)
            }else if bill > 1 && bill <= 100{
                self.mouthEarnData.append(bill/150)
            }else if bill > 100 && bill <= 1000{
                self.mouthEarnData.append(bill/1500)
            }else if bill > 1000 && bill <= 10000{
                self.mouthEarnData.append(bill/15000)
            }else if bill > 10000 && bill <= 100000{
                self.mouthEarnData.append(bill/150000)
            }else if bill == 0{
                self.mouthEarnData.append(0)
            }
            
           
         
        }
      
    }
}
