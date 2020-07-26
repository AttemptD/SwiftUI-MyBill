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
    var doWhat = ""
    
}

class AppData: ObservableObject {
    
    var BillDatas = [Model]()
    var EaringDatas = [Model]()
    var payDatas = [Model]()
    
    var TodayBill = [Model]()
    
    var TodayPay : Double = 0
    var TodayEarning : Double = 0
    
    var Bill_ten = [Model]()
    
    init() {
        getBillData()
        EarningData()
        payData()
        getTodayAllBills()
        getTodayPay_Earn()
        getAllBill_Ten()
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
        
        
        self.BillDatas.removeAll()
        self.EaringDatas.removeAll()
        self.payDatas.removeAll()
        self.TodayBill.removeAll()
        self.Bill_ten.removeAll()
        
        self.getBillData()
        self.EarningData()
        self.payData()
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
        RealmDB().insert(model: billData)
    }
    
    func updataBillData(time:String,money:Double,type:String,doWhat:String)  {
        let billData = Model()
        billData.doWhat = doWhat
        billData.type = type
        billData.money = money
        billData.time = time
        billData.blurTime = String(time.prefix(11))
        RealmDB().update(model: billData)
    }
    
    func getBillData() {
        
        let bill = RealmDB().getDB().objects(Bill.self).sorted(byKeyPath: "time",ascending: false)
        
        for Bills in bill{
            
            let billData = Model()
            billData.id = self.BillDatas.count
            billData.doWhat = Bills.doWhat
            billData.money = Bills.money
            billData.type = Bills.type
            billData.time = Bills.time
            billData.blurTime = String(Bills.time.prefix(11))
            
            self.BillDatas.append(billData)
        }
    }
    
    func EarningData() {
        let earn = RealmDB().getDB().objects(Bill.self).filter(" type == '收入'").sorted(byKeyPath: "time", ascending: false)
        for Earn in earn{
            let EarnData = Model()
            EarnData.id = self.EaringDatas.count
            EarnData.doWhat = Earn.doWhat
            EarnData.money = Earn.money
            EarnData.type = Earn.type
            EarnData.time = Earn.time
            EarnData.blurTime = String(Earn.time.prefix(11))
            self.EaringDatas.append(EarnData)
        }
    }
    
    func payData() {
        let payout = RealmDB().getDB().objects(Bill.self).filter(" type == '支出' ").sorted(byKeyPath: "time", ascending: false)
        for Pay in payout{
            let payData = Model()
            payData.id = self.payDatas.count
            payData.doWhat = Pay.doWhat
            payData.money = Pay.money
            payData.type = Pay.type
            payData.time = Pay.time
            payData.blurTime = String(Pay.time.prefix(11))
            
            self.payDatas.append(payData)
        }
    }
    
    func getTodayAllBills() {
        
        let todayBill = RealmDB().getDB().objects(Bill.self).filter(" blurTime == '\(TimeTools().getDay(value : 0,Timetype : "yyyy年MM月dd日"))' ").sorted(byKeyPath: "time", ascending: true)
        
        for today in todayBill{
            let todayData = Model()
            todayData.id = self.TodayBill.count
            todayData.doWhat = today.doWhat
            todayData.money = today.money
            todayData.type = today.type
            todayData.time = today.time
            todayData.blurTime = String(today.time.prefix(11))
            
            self.TodayBill.append(todayData)
        }
    }
    
    func getTodayPay_Earn()  {
        let TodayPayOut : Double = RealmDB().getDB().objects(Bill.self).filter(" blurTime == '\(TimeTools().getDay(value : 0,Timetype : "yyyy年MM月dd日"))' AND type == '支出' ").sum(ofProperty: "money")
        
        self.TodayPay = TodayPayOut
        
        let TodayEarn : Double = RealmDB().getDB().objects(Bill.self).filter(" blurTime == '\(TimeTools().getDay(value : 0,Timetype : "yyyy年MM月dd日"))' AND type == '收入' ").sum(ofProperty: "money")
        
        self.TodayEarning = TodayEarn
    }
    
    func getAllBill_Ten() {
        let bill = RealmDB().getDB().objects(Bill.self).sorted(byKeyPath: "time",ascending: false)
        let bills = RealmDB().getDB().objects(Bill.self).sorted(byKeyPath: "time",ascending: false)
        
    
        if bills.count > 8 {
            for i in 0 ..< 7{
                let billData = Model()
                let bill_ten = bills[i]
                
                
                billData.id = self.Bill_ten.count
                billData.doWhat = bill_ten.doWhat
                billData.money = bill_ten.money
                billData.type = bill_ten.type
                billData.time = bill_ten.time
                billData.time = String(bill_ten.blurTime.prefix(11))

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
                
                self.Bill_ten.append(billData)
            }
        }
    }
}
