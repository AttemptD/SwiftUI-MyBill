//
//  NewAddBillView.swift
//  pageView
//
//  Created by Attempt D on 2020/7/10.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct NewAddBillView: View {
    @State var select = ""  //类型
    @State var money = ""  //钱
    @State var time = Date()
    @State var doWhat = ""
    @State var showWarn = false
    @ObservedObject var appData : AppData
    let billData : Model
    @State var OpenType : String
    @State var showPay = true
    @State var showEarn = true
    @State var showLine_money = false
    @State var showLine_doWhat = false
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        KeyboardHost{
            
            NavigationView{
                
                ZStack(alignment:.top){
                    
                    VStack{
                        
                        
                        Text("新建")
                            .font(.system(size: 20))
                            .fontWeight(.light)
                            .padding(.leading,25)
                            .frame(width: width,alignment: .leading)
                            .padding(.top,50)
                        
                        
                        
                        
                        Spacer().frame(height: 25)
                        
                        ScrollView(showsIndicators:false){
                            
                            VStack{
                                
                                VStack(alignment:.leading){
                                    
                                    HStack{
                                        Text("账单类型")
                                            .font(.system(size: 12))
                                            .fontWeight(.light)
                                            .padding([.leading,.top],20)
                                        
                                        Spacer()
                                        
                                        if showPay == false || showEarn == false{
                                            Button(action: {
                                                self.showPay = true
                                                self.showEarn = true
                                                
                                                self.select = ""
                                            }) {
                                                Text("修改")
                                                    .font(.system(size: 12))
                                                    .fontWeight(.light)
                                                    .frame(height: 20, alignment: .center)
                                                    .padding(.horizontal,5)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 5)
                                                            .stroke(Color.init("MainThemeColor"), lineWidth: 1)
                                                )
                                                    .padding([.trailing,.top],20)
                                            }
                                            
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    HStack{
                                        
                                        if showEarn == true{
                                            
                                            Button(action: {
                                                self.select = "收入"
                                                self.showPay = false
                                            }) {
                                                HStack{
                                                    Image("收入-1")
                                                        .resizable()
                                                        .frame(width:35,height:35)
                                                    
                                                    if showPay == false{
                                                        Spacer().frame( width: 15)
                                                    }
                                                    Text("收入")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 16))
                                                }.frame(width: showPay == false ? width-100 : 100, height: 40, alignment: .center)
                                                    .background(Color.init("MainThemeColor"))
                                                    .cornerRadius(10)
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        if showPay == true{
                                            Button(action: {
                                                self.select = "支出"
                                                self.showEarn = false
                                            }) {
                                                HStack{
                                                    Image("支出-1")
                                                        .resizable()
                                                        .frame(width:35,height:35)
                                                    
                                                    if showEarn == false{
                                                        Spacer().frame( width: 15)
                                                    }
                                                    Text("支出")
                                                        .foregroundColor(.gray)
                                                        .font(.system(size: 16))
                                                }.frame(width: showEarn == false ? width-100 : 100, height: 40, alignment: .center)
                                                    .background(Color.init("MainCellSpacerColor"))
                                                    .cornerRadius(10)
                                                
                                            }
                                        }
                                        
                                    }
                                    .padding(.horizontal,30)
                                    .frame(width: width-40,alignment: .center)
                                    .animation(.spring())
                                    
                                }.frame(width: width-40,alignment: .leading)
                                
                                
                                Spacer().frame( height: 30)
                                
                                DatePacker(title: "选择时间", date: self.$time, datetype: true)
                                    .padding(.leading,20)
                                    .padding(.trailing,25)
                                
                                
                                Spacer().frame( height: 30)
                                
                                
                                VStack(alignment:.leading){
                                    
                                    Text("收入/支出费用")
                                        .font(.system(size: 12))
                                        .fontWeight(.light)
                                        .padding(.leading,20)
                                        .padding(.bottom,10)
                                    
                                    HStack{
                                        MyTextField(keyboardType: .decimalPad, text: $money, placeholder:  "请输入数字",showLine:$showLine_money)
                                            .frame( height: 40)
                                        
                                        
                                    }.overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.init("MainThemeColor"), lineWidth: showLine_money == true ? 1 : 0)
                                            .animation(.linear)
                                    )
                                        .padding(.horizontal,20)
                                    
                                    
                                }.frame(width: width-40,alignment:.leading)
                                
                                
                                Spacer().frame( height: 30)
                                
                                
                                VStack(alignment:.leading){
                                    
                                    Text("收入/支出原因")
                                        .font(.system(size: 12))
                                        .fontWeight(.light)
                                        .padding(.leading,20)
                                        .padding(.bottom,10)
                                    
                                    
                                    HStack{
                                        MyTextField(keyboardType: .default, text: $doWhat, placeholder:  "例如发红包/收红包", showLine:$showLine_doWhat)
                                            .frame( height: 40)
                                        
                                        
                                    }.overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.init("MainThemeColor"), lineWidth: showLine_doWhat == true ? 1 : 0)
                                            .animation(.linear)
                                    )
                                        .padding(.horizontal,20)
                                    
                                }.frame(width: width-40,alignment:.leading)
                                
                                Spacer().frame( height: 30)
                            }
                            .frame(width: width-40, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(15)
                            
                            
                            
                            Spacer().frame( height: 90)
                            
                            
                            Button(action: {
                                if self.money != "" && self.select != ""{
                                    let Money :Double = Double(self.money)!
                                    
                                    if self.OpenType == "新建"{
                                        
                                        DispatchQueue.main.async {
                                            self.appData.setBillData(time: TimeTools().dataToTime(date: self.time, type: "yyyy年MM月dd日 HH:mm:ss"), money: Money, type: self.select, doWhat: self.doWhat)
                                            
                                            
                                            self.appData.NowData(time: TimeTools().dataToTime(date: self.time, type: "yyyy年MM月dd日 HH:mm:ss"), money: Money, type: self.select, doWhat: self.doWhat)
                                            
                                            
                                        }
                                    }else{
                                        self.appData.updataBillData(time: TimeTools().dataToTime(date: self.time, type: "yyyy年MM月dd日 HH:mm:ss"), money: Money, type: self.select, doWhat: self.doWhat)
                                    }
                                    
                                    DispatchQueue.main.async {
                                        self.appData.refreshData()
                                    }
                                    
                                    self.presentationMode.wrappedValue.dismiss()
                                    
                                    
                                }else{
                                    self.showWarn.toggle()
                                }
                            }) {
                                Text("\(OpenType)账单")
                                    .foregroundColor(.white)
                                    .frame(width: 200, height: 50, alignment: .center)
                                    .background(Color.init("MainThemeColor"))
                                    .cornerRadius(15)
                                
                            }
                                
                            .alert(isPresented: $showWarn) {
                                Alert(title: Text("提示"),
                                      message: Text( self.select == "" ? "请选择账单类型":"请输入收入支出费用"),
                                      dismissButton: .default(Text("我知道了")))
                            }
                        }
                        .frame(width: width, alignment: .center)
                        .background(Color.init("MainCellSpacerColor"))
                        
                        
                    }
                    .background(Color.init("MainCellSpacerColor"))
                    
                    HStack{
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.down")
                                
                                .foregroundColor(Color.init("MainThemeColor"))
                                .scaleEffect(1.5)
                            
                        }
                    } .padding(.leading,30)
                        .frame(width: width,height:50,alignment: .leading)
                    
                }
                    
                .buttonStyle(PlainButtonStyle())
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
            .onAppear(){
                
                if self.OpenType == "修改"{
                    
                    self.doWhat = self.billData.doWhat
                    self.money = String(self.billData.money)
                    
                    print(String(self.billData.money))
                    
                    if self.billData.type == "支出"{
                        
                        self.showPay = true
                        self.showEarn = false
                        self.select = "支出"
                        
                    }else{
                        self.showPay = false
                        self.showEarn = true
                        self.select = "收入"
                    }
                    self.time = TimeTools().stringConvertDate(string: self.billData.time)
                }
            }
            .onDisappear(){
                self.doWhat = ""
                self.money = ""
                
                self.time = Date()
            }
            
        }.edgesIgnoringSafeArea(.all)
        
        
    }
    
}



struct NewBuild_Update_Previews: PreviewProvider {
    static var previews: some View {
        NewAddBillView(appData: AppData(), billData: Model(), OpenType: "")
    }
}
