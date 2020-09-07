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
    @State var barTitle = "主页"
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
                        
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(self.colorScheme == .dark ? Color.gray:Color.init("FontColor"))
                    }
                } .frame(width: width-60,  alignment: .center)
                    .offset(x:0,y:-height/12)
                    .animation(.none)
                
                
                HomeContent(appData: appData,folderData:folderData)
                
                
            }
            .background(colorScheme == .dark ? Color.black : Color.init("MainCellSpacerColor"))
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
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
                        Text("收入")
                            .font(.system(size: 11))
                            .fontWeight(.thin)
                        
                    }
                }
                
                Spacer()
                
                HStack{
                    Image(colorScheme == .dark ? "支出-1_dark":"支出-1")
                        .resizable()
                        .frame(width: 35, height: 35)
                    
                    VStack(alignment:.leading){
                        Text("\(transer(value: appData.TodayPay))元")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(self.colorScheme == .dark ? Color.gray:Color.init("FontColor"))
                        Text("支出")
                            .font(.system(size: 11))
                            .fontWeight(.thin)
                        
                    }
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
    @State var updateBill = false
    @ObservedObject var appData : AppData
     @ObservedObject var folderData : FolderData
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ScrollView {
            ForEach(appData.TodayBill.count != 0 ? appData.TodayBill : appData.Bill_ten){item in
                
                NavigationLink(destination:DetailView(billData: item)){
                    
                    HStack{
                        VStack{
                            HStack{
                                if item.type == "收入"{
                                    
                                    Image("收入")
                                        .resizable()
                                        .frame(width:35,height:35)
                                        .foregroundColor(.orange)
                                }else{
                                    Image("支出")
                                        .resizable()
                                        .frame(width:35,height:35)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text(item.doWhat)
                                    .font(.system(size:16))
                            }.padding(.horizontal,10)
                                .shadow(radius: 0)
                            
                            Text("\(transer(value:item.money))元")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .padding(.bottom,15)
                                
                                .foregroundColor(self.colorScheme == .dark ? Color.gray:Color.init("FontColor"))
                            
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
                    .frame(width: width-60, height: item.lastOne ? (width-60)/2 + 54 : (width-60)/2, alignment:Double(item.id).truncatingRemainder(dividingBy: 2) == 0 ? .leading:.trailing)
                    .offset(y:item.left ? 0 : -20)
                    .shadow(radius: 3)
                    .animation(.none)
                    .padding(.bottom, item.lastOne ? -60 : -80)
                    
                    
                }
                .buttonStyle(PlainButtonStyle())
                
                
            }.id(UUID())
                .frame(width:width)
            
            
            
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
