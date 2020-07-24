//
//  NewAddBillView.swift
//  pageView
//
//  Created by Attempt D on 2020/7/10.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct NewAddBillView: View {
    @State var select = ["收入","支出"]
    @State var type = 0
    @State var money = ""
    @State var time = Date()
    @State var doWhat = ""
    @State var showWarn = false
    @ObservedObject var appData : AppData
    let billData : Model
    @State var OpenType : String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        
        NavigationView{
            KeyboardHost{
                Form{
                    
                    HStack{
                        Picker(selection: $type, label: Text("选择账单类型")) {
                            ForEach(self.select.indices,id: \.self){
                                Text(self.select[$0])
                                
                            }
                        }
                    }
                    
                    Section(header: Text("选择时间")) {
                        DatePacker(title: "账单日期", date: self.$time, datetype: true)
                    }
                    
                    Section(header: Text("收入/支出费用")) {
                        HStack{
                            
                            MyTextField(keyboardType: .decimalPad, text: $money, placeholder:  "请输入数字")
                            
                            Text("元")
                        }
                    }
                    
                    Section(header: Text("花销原因")) {
                        MyTextField(keyboardType: .default, text: $doWhat, placeholder: "例如发红包/收红包")
                        
                    }
                    
                    
                }
                    
                .navigationBarTitle("新建",displayMode: .inline)
                .navigationBarItems(
                    leading:
                    Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
                        Text("取消").foregroundColor(.gray)
                    },
                    trailing:
                    Button(action: {
                        
                        if self.money != ""{
                            let Money :Double = Double(self.money)!
                            
                            if self.OpenType == "新建"{
                                
                                DispatchQueue.main.async {
                                    self.appData.setBillData(time: TimeTools().dataToTime(date: self.time, type: "yyyy年MM月dd日 HH:mm:ss"), money: Money, type: self.select[self.type], doWhat: self.doWhat)
                                    
                                    
                                    self.appData.NowData(time: TimeTools().dataToTime(date: self.time, type: "yyyy年MM月dd日 HH:mm:ss"), money: Money, type: self.select[self.type], doWhat: self.doWhat)
                                    
                                    
                                }
                            }else{
                                self.appData.updataBillData(time: TimeTools().dataToTime(date: self.time, type: "yyyy年MM月dd日 HH:mm:ss"), money: Money, type: self.select[self.type], doWhat: self.doWhat)
                            }
                            
                            DispatchQueue.main.async {
                                self.appData.refreshData()
                            }
                            
                            self.presentationMode.wrappedValue.dismiss()
                            
                            
                        }else{
                            self.showWarn.toggle()
                        }
                    }) {
                        Text("完成")
                })
                    .alert(isPresented: $showWarn) {
                        Alert(title: Text("提示"),
                              message: Text("请输入收入或支出费用"),
                              dismissButton: .default(Text("我知道了")))
                }
                
                
                
            }
        }
            
        .onAppear(){
            
            if self.OpenType == "修改"{
                self.doWhat = self.billData.doWhat
                self.money = String(self.billData.money)
                
                
                if self.billData.type == "支出"{
                    
                    self.select = ["支出","收入"]
                }else{
                     self.select = ["收入","支出"]
                }
                self.time = TimeTools().stringConvertDate(string: self.billData.time)
            }
        }
        .onDisappear(){
            self.doWhat = ""
            self.money = ""
            
            self.time = Date()
        }
    }
    
}


