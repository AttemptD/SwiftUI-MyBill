//
//  MyCenterView.swift
//  PageView
//
//  Created by Attempt D on 2020/6/22.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI
import Charts


struct MyCenterView: View {
    @ObservedObject var appData : AppData
    @ObservedObject var mycenterdata : MyInfoData
    @Environment(\.colorScheme) var colorScheme
    @State var window: UIWindow
    @State var billType = "支出"
    var body: some View {
        ZStack(alignment:.topTrailing){
            FancyScrollView(title: "我的",
                            headerHeight: height/3,
                            scrollUpHeaderBehavior: .parallax,
                            scrollDownHeaderBehavior: .offset,
                            cornerRadiusNub:15,
                            showTitle:false,
                            header: {
                                MyViewBackground(mycenterdata: mycenterdata)
            }){
                
                    VStack(spacing:20){
                        
                        UserAllMoney(appData: appData)
                        
                      
                        WeekChartData(title: "7天的支出情况",appData: appData.weekData, time: getweekTime(), billType: $billType)
                            .id(UUID())
                        
                        WeekChartData(title: billType == "支出" ? "7月的支出情况" : "7月的收入情况",appData:billType == "支出" ? appData.mouthData : appData.mouthEarnData, time: getMouthTime(), billType: $billType)
                            .id(UUID())
                        

                    }
                    .background(colorScheme == .dark ? Color.black : Color.init("MainCellSpacerColor"))
                    
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(colorScheme == .dark ? Color.black : Color.init("MainCellSpacerColor"))
           
            .navigationBarTitle("我的",displayMode: .inline)
            .navigationBarHidden(true)
            
            
            SettingButton(mycenterdata: mycenterdata, window: window)
            
            
        }
        .onAppear(){
            self.appData.getMyCenterData()
            
        
        }
        
    }
}

struct UserAllMoney: View {
    @ObservedObject var appData : AppData
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            
            HStack{
                
                VStack{
                    Text(appData.AllMony)
                        .font(.system(size: 25))
                        .frame(width:(width-40)/4)
                    Text("全部")
                        .font(.system(size: 15))
                        .fontWeight(.thin)
                        .frame(width:(width-40)/4)
                    
                }.frame(width:(width-40)/4)
                
                VStack{
                    Divider().frame(width: 1, height: 50, alignment: .center)
                        .background(colorScheme == .dark ?  Color.black : Color.init("MainCellSpacerColor"))
                }
                
                
                VStack{
                    Text(appData.PayMoney)
                        .font(.system(size: 25))
                        .frame(width:(width-40)/4)
                    Text("支出")
                        .font(.system(size: 15))
                        .fontWeight(.thin)
                        .frame(width:(width-40)/4)
                }.frame(width:(width-40)/4)
                
                VStack{
                    Divider().frame(width: 1, height: 50, alignment: .center)
                        .background(colorScheme == .dark ? Color.black : Color.init("MainCellSpacerColor"))
                }
                
                VStack{
                    Text(appData.EaringMoney)
                        .font(.system(size: 25))
                        .frame(width:(width-40)/4)
                    Text("收入")
                        .font(.system(size: 15))
                        .fontWeight(.thin)
                        .frame(width:(width-40)/4)
                    
                }.frame(width:(width-40)/4)
                
                
            }
            .padding(.horizontal)
            .frame(width: width-20, height: height/8, alignment: .center)
            .background(self.colorScheme == .dark ? Color.init("MainCellSpacerColor_dark")  :Color.white)
            .cornerRadius(15)
            .padding(.top,20)
            
            
        }
        .background(colorScheme == .dark ? Color.black : Color.init("MainCellSpacerColor"))
    }
}

struct MyViewBackground: View {
    @ObservedObject var mycenterdata : MyInfoData
    @State var gotoEditView = false
    var body: some View {
        Image(uiImage: ImageTranser().DataToImage(data: mycenterdata.headerIco))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .blur(radius: 5,opaque: true)
            .overlay(Color.init("MyCenterColor"))
            .overlay(
                NavigationLink(destination: SetInfoView(mycenterdata: mycenterdata, openType: "修改"), isActive: $gotoEditView){
                    Image(uiImage: ImageTranser().DataToImage(data: mycenterdata.headerIco))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 85, height: 85, alignment: .center)
                        .clipped()
                        .cornerRadius(50)
                        .onTapGesture {
                            self.gotoEditView.toggle()
                    }
                }.buttonStyle(PlainButtonStyle())
        )
    }
}

struct SettingButton: View {
    @ObservedObject var mycenterdata : MyInfoData
    @State var window: UIWindow
    @State var gotoSetting = false
    var body: some View {
        NavigationLink(destination:SettingView(mycenterdata:self.mycenterdata,window: self.window),isActive: self.$gotoSetting){
            Button(action: {
                self.gotoSetting.toggle()
            }) {
                Image(systemName: "ellipsis")
                    .scaleEffect(1.1)
                    .foregroundColor(.white)
                    .padding(.trailing,25)
                    .padding(.top,10)
                
            }.frame(width: 50, height: 30, alignment: .center)
                .contentShape(Rectangle())
            
            
        }.buttonStyle(PlainButtonStyle())
    }
}

struct WeekChartData: View {
   
    @State var title : String
    @State var appData : [Double]
    @State var time : [String]
    @Binding var billType : String
    @Environment(\.colorScheme) var colorScheme
    @State var showWeekDataView = false
    var body: some View {
        VStack{
            
            Chart(data:appData)
                .chartStyle( LineChartStyle(.quadCurve, lineColor: Color.init("MainThemeColor"), lineWidth: 2))
                .padding()
                .padding(.bottom,20)
                .animation(.easeIn)
               
        }
        .frame(width: width - 20, height: height/5, alignment: .center)
        .background(self.colorScheme == .dark ? Color.init("MainCellSpacerColor_dark")  :Color.white)
        .cornerRadius(15)
        .overlay(
            VStack{
                HStack{
                    Text(title)
                        .padding(.leading,20)
                        .foregroundColor(Color.init("FontColor"))
                    
                    
                        Spacer()
                        
                        Button(action: {
                            
                            if(billType == "支出"){
                                billType = "收入"
                                return
                            }
                            if(billType == "收入"){
                                billType = "支出"
                                return
                            }
                            
                        }) {
                            Text(billType)
                        }
                        .padding(.trailing,20)
                        .disabled(title != "7天的支出情况" ? false : true)
                        .opacity(title != "7天的支出情况" ? 1 : 0)
                    
                   
                }
                .frame(width: width - 20,alignment: .leading)
                .font(.system(size: 15))
                .padding(.top,10)
                
                Spacer()
                
                HStack{
                    ForEach(time,id: \.self){
                        
                        Text("\($0)")
                            .font(.system(size: 13))
                            .foregroundColor(Color.init("FontColor"))
                            .frame(width: (width-20)/8.3, alignment: .center)
                        
                    }
                }
                .frame(width: width - 20,alignment: .center)
                .padding(.bottom,10)
                
            }
            .frame(width: width - 20, height: height/5, alignment: .topLeading)
            .contentShape(Rectangle())
            .cornerRadius(15)
        )
        
        .onTapGesture(count: 1, perform: {
            showWeekDataView.toggle()
        })
        .sheet(isPresented: $showWeekDataView, content: {
            chartView_detail(appData:appData)
        })
    }
}
