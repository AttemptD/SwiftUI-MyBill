//
//  test.swift
//  MyBill
//
//  Created by Attempt D on 2020/8/25.
//  Copyright © 2020 Frank D. All rights reserved.
//



import SwiftUI

struct Home: View {
    @State var scrollViewContentOffset : CGFloat = 0
    @State private var scale: CGFloat = 1.0
    @State var isDelete = false
    @State var barTitle = "主页"
    @State var selectList = [Model]()
    @ObservedObject var appData : AppData
    @ObservedObject var folderData : FolderData
    @ObservedObject var mycenterdata : MyInfoData
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        FancyScrollView(title: "主页",
                        headerHeight: height/3,
                        scrollUpHeaderBehavior: .parallax,
                        scrollDownHeaderBehavior: .offset,
                        cornerRadiusNub:15,
                        showTitle:false,
                        header: {
                            HomeBackground(appData:appData,mycenterdata:mycenterdata)
                            
                            
                        }) {
            VStack{
                HomePersonInfo(appData:appData,mycenterdata:mycenterdata)
                
                HStack{
                    Text(appData.TodayBill.count == 0 ? "往期的账单" : "今天的账单")
                        .font(.system(size:20))
                        .bold()
                        .foregroundColor(self.colorScheme == .dark ? Color.gray:Color.init("FontColor"))
                    Spacer()
                    Button(action: {
                        
                        if selectList.count == 0 {
                            isDelete.toggle()
                        }else{
                            
                            withAnimation(.easeOut){
                                DispatchQueue.main.async {
                                    
                                    for i in 0..<selectList.count{
                                        
                                        let child = selectList[i]
                                        if self.appData.TodayBill.count == 1 || self.appData.Bill_ten.count == 1 {
                                            RealmDB().deleteFolder(time: child.blurTime)
                                        }
                                        
                                        if(self.appData.TodayBill.count != 0){
                                            
                                            for t in 0..<appData.TodayBill.count{
                                                
                                                let todayBill = appData.TodayBill[t]
                                                
                                                if(child.time == todayBill.time){
                                                    appData.TodayBill.remove(at: t)
                                                    break
                                                }
                                                
                                            }
                                            
                                        }else{
                                           
                                            for b in 0..<appData.Bill_ten.count{
                                                
                                                let bill_ten = appData.Bill_ten[b]
                                                
                                                if(child.time == bill_ten.time){
                                                    appData.Bill_ten.remove(at: b)
                                                    break
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                        RealmDB().delete(time: child.time)
                                        
                                        self.appData.refreshData()
                                        self.folderData.setFoloderBillData()
                                    }
                                    
                                    selectList.removeAll()
                                }
                                isDelete.toggle()
                            }
                            
                        }
                        
                       
                        
                    }) {
                        Image(systemName:selectList.count == 0 ? isDelete ? "arrow.uturn.left" : "ellipsis" : "trash")
                            .foregroundColor(self.colorScheme == .dark ? Color.gray:Color.init("FontColor"))
                    }
                }
                .frame(width: width-60,  alignment: .center)
                .offset(x:0,y:-height/12)
                .animation(.none)
                
                
                HomeContent(isDelete: $isDelete,selectList:$selectList ,appData: appData,folderData:folderData)
                
                
            }
            .background(colorScheme == .dark ? Color.black : Color.init("MainCellSpacerColor"))
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(colorScheme == .dark ? Color.black : Color.init("MainCellSpacerColor"))
        .navigationBarTitle("主页").navigationBarHidden(true)
        .onAppear(){
            self.appData.refreshData()
        }
    }
}


struct HomeBackground: View {
    @ObservedObject var appData : AppData
    @ObservedObject var mycenterdata : MyInfoData
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Image(uiImage:ImageTranser().DataToImage(data: mycenterdata.background)).resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(Color.init(colorScheme == .dark ?  "MyCenterColor" :"tanser"))
            .overlay(
                
                VStack{
                    
                    HStack{
                        Text(appData.TodayEarning - appData.TodayPay < 0 ? "支出" : "收入")
                            .bold()
                            .font(.system(size: 20))
                            
                            .foregroundColor(self.colorScheme == .dark ? Color.gray:Color.init("FontColor"))
                        
                        Spacer()
                        
                        Text(appData.TodayEarning - appData.TodayPay < 0 ? "¥\(transer(value: appData.TodayPay - appData.TodayEarning))" : "¥\(transer(value: appData.TodayEarning - appData.TodayPay))")
                            
                            .font(.system(size: 25))
                            .foregroundColor(self.colorScheme == .dark ? Color.gray:Color.init("FontColor"))
                        
                        
                        
                    }
                    .padding(.bottom,50)
                    .foregroundColor(.black)
                    
                }
                
                .frame(width: width-60, height: height/3.5,alignment: .center)
                
            )
    }
}

struct HomePersonInfo: View {
    @ObservedObject var appData : AppData
    @ObservedObject var mycenterdata : MyInfoData
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            Image(uiImage:ImageTranser().DataToImage(data: mycenterdata.headerIco))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60, alignment: .center)
                .clipped()
                .cornerRadius(50)
            
            Text(mycenterdata.name)
                .bold()
                .foregroundColor(self.colorScheme == .dark ? Color.gray:Color.init("FontColor"))
            
            HStack(alignment: .center){
                
                HStack{
                    Image(colorScheme == .dark ? "收入-1_dark" : "收入-1")
                        .resizable()
                        .frame(width: 35, height: 35)
                    VStack(alignment:.leading){
                        Text("\(transer(value: appData.TodayEarning))元")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(self.colorScheme == .dark ? Color.gray:Color.init("FontColor"))
                            .frame(width: 70, height: 30, alignment: .leading)
                            
                        Text("收入")
                            .font(.system(size: 11))
                            .fontWeight(.thin)
                        
                    }
                }
                
                Spacer()
                
                HStack{
                    VStack(alignment:.trailing){
                        Text("\(transer(value: appData.TodayPay))元")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(self.colorScheme == .dark ? Color.gray:Color.init("FontColor"))
                            .frame(width: 70, height: 30, alignment: .trailing)
                        
                        Text("支出")
                            .font(.system(size: 11))
                            .fontWeight(.thin)
                        
                    }
                    Image(colorScheme == .dark ? "支出_dark":"支出-1")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
            }
            .padding(.horizontal,width/10)
            .frame(width: width-60,  alignment: .center)
            
            
        }
        .frame(width: width-60, height: 190, alignment: .center)
        .background(colorScheme == .dark ?  Color.init("MainCellSpacerColor_dark") :Color.white)
        .shadow(radius: 10)
        .cornerRadius(10)
        .offset(x:0,y:-height/8)
        .animation(.none)
    }
}

struct HomeContent: View {
    @State var billdata = Model()
    @State var billdata_money = ""
    @State var updateBill = false
    @Binding var isDelete : Bool
    @Binding var selectList : [Model]
    @ObservedObject var appData : AppData
    @ObservedObject var folderData : FolderData
    @Environment(\.colorScheme) var colorScheme
   
    var body: some View {
        ScrollView {
            ForEach(appData.TodayBill.count != 0 ? appData.TodayBill : appData.Bill_ten){item in
                
                
                HStack{
                    VStack{
                        HStack{
                            
                            if !isDelete{
                                Image(item.type == "收入" ? "收入" : "支出")
                                    .resizable()
                                    .frame(width:35,height:35)
                                    .foregroundColor(item.type == "收入" ? .orange : .gray)
                                
                            }else{
                                Button(action: {
                                    appData.changeStatus(item: item)
                                    
                                    if item.isSelect {
                                        selectList.append(item)
                                    }else{
                                        
                                        for i in 0..<selectList.count {
                                            let child = selectList[i]
                                            
                                            if(item.time == child.time){
                                                selectList.remove(at: i)
                                                break
                                            }
                                        }
                                       
                                    }
                                   
                                    
                                }) {
                                    Image(systemName: "checkmark.circle")
                                        .resizable()
                                        .frame(width:30,height:30)
                                        .foregroundColor(item.isSelect ? .orange : .gray)
                                }
                            }
                            
                           
                            Spacer()
                            Text(item.doWhat)
                                .font(.system(size:16))
                        }.padding(.horizontal,10)
                        .shadow(radius: 0)
                        
                        Text("\(transer(value:item.money))元")
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                            .foregroundColor(self.colorScheme == .dark ? Color.gray:Color.init("FontColor"))
                            .padding(.horizontal,15)
                            .frame(width:(width-60)/2-10,height:40)
                            .padding(.bottom,10)
                            
                            .minimumScaleFactor(0.3)
                        Text(item.blurTime)
                            .foregroundColor(.gray)
                            .fontWeight(.light)
                            .font(.system(size:14))
                        
                    }
                    .frame(width: (width-60)/2-10,height:  (width-60)/2-25, alignment: .center)
                    .background(self.colorScheme == .dark ?  Color.init("MainCellSpacerColor_dark") :Color.white)
                    .cornerRadius(10)
                    .contextMenu(){
                        Button(action: {
                            
                            self.updateBill.toggle()
                            self.billdata = item
                            self.billdata_money = String(item.money)
                            
                        }) {
                            Text("修改")
                            Image(systemName: "pencil")
                        }
                        
                        
                        Button(action: {
                            
                            
                            withAnimation(.easeOut){
                                DispatchQueue.main.async {
                                    
                                    if self.appData.TodayBill.count == 1 || self.appData.Bill_ten.count == 1 {
                                        RealmDB().deleteFolder(time: item.blurTime)
                                    }
                                    
                                    if(self.appData.TodayBill.count != 0){
                                        self.appData.TodayBill.remove(at: item.id)
                                    }else{
                                        self.appData.Bill_ten.remove(at:item.id)
                                        
                                    }
                                    
                                    RealmDB().delete(time: item.time)
                                    
                                    self.appData.refreshData()
                                    self.folderData.setFoloderBillData()
                                }
                            }
                            
                        }) {
                            Text("删除")
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        
                    }
                    .offset(y: item.lastOne ? -27:0)
                    
                }
                .frame(width: width-60, height: forHeight(isBool: item.lastOne), alignment:Double(item.id).truncatingRemainder(dividingBy: 2) == 0 ? .leading:.trailing)
                .offset(y:item.left ? 0 : -20)
                .shadow(radius: 3)
                .animation(.none)
                .padding(.bottom, item.lastOne ? -60 : -80)
            }
            
            .frame(width:width)
            .sheet(isPresented: self.$updateBill) {
                
                NewAddBillView(appData:self.appData,folderData: self.folderData ,billData:self.$billdata ,OpenType: "修改",editMoney:self.$billdata_money)
            }
            .id(UUID())
            
            
        }
        .offset(y:-60)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

func forHeight(isBool:Bool) -> CGFloat {
    if isBool {
        return (width-60)/2 + 54
    }else{
        return (width-60)/2
    }
}
