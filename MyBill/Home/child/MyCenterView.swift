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
                        
                      
                        WeekChartData(appData: appData)
                        
//                        HStack{
//
//
//                            VStack(spacing:12){
//                                Circle()
//                                    .rotation(.degrees(-90))
//                                    .trim(from:  0, to: 0.5)
//                                    .stroke(Color.yellow, lineWidth: 5)
//
//                                    .frame(width: 60, height: 60, alignment: .center)
//                                    .background(colorScheme == .dark ? Color.white :Color.init("MainCellSpacerColor"))
//                                    .cornerRadius(90)
//                                    .overlay(
//                                        Image(systemName: "paperplane.fill")
//                                            .resizable()
//                                            .frame(width: 25, height: 25, alignment: .center))
//
//                                VStack(spacing:5){
//                                Text("0.50")
//
//                                Text("出行")
//                                    .font(.system(size: 12))
//                                    .foregroundColor(Color.gray)
//                                }
//                            }
//
//
//                        }
//                        .frame(width: width - 20, height: height/5, alignment: .center)
//                        .background(self.colorScheme == .dark ? Color.init("MainCellSpacerColor_dark")  :Color.white)
//                        .cornerRadius(15)
//                        .padding(.bottom,20)
                    }
                    .background(colorScheme == .dark ? Color.black : Color.init("MainCellSpacerColor"))
                    
                    
                
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(colorScheme == .dark ? Color.black : Color.init("MainCellSpacerColor"))
           
            .navigationBarTitle("我的",displayMode: .inline)
            .navigationBarHidden(true)
            .onAppear(){
                self.appData.getMyCenterData()
                
            
            }
            
            SettingButton(mycenterdata: mycenterdata, window: window)
            
            
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
                NavigationLink(destination: EmptyView(), isActive: $gotoEditView){
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
    @ObservedObject var appData : AppData
    @Environment(\.colorScheme) var colorScheme
    @State var showWeekDataView = false
    var body: some View {
        VStack{
            
            Chart(data:appData.weekData)
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
                    Text("7天的支出情况")
                        .padding(.leading,20)
                        .foregroundColor(Color.init("FontColor"))
                }
                .frame(width: width - 20,alignment: .leading)
                .font(.system(size: 15))
                .padding(.top,10)
                
                Spacer()
                
                HStack{
                    ForEach(getweekTime(),id: \.self){
                        
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
        
        .onTapGesture(count: 2, perform: {
            showWeekDataView.toggle()
        })
        .sheet(isPresented: $showWeekDataView, content: {
            EmptyView()
        })
    }
}
