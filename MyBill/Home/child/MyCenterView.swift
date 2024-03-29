//
//  MyCenterView.swift
//  PageView
//
//  Created by Attempt D on 2020/6/22.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

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
                        
                      
                        ChartTagle(appData: appData.weekData, time: getweekTime())
                            .id(UUID())
                          
                        ChartTagle(appData:billType == "支出" ? appData.mouthData : appData.mouthEarnData, time: getMouthTime())
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
            
            let controller = UIApplication.shared.windows[0].rootViewController as? MyHontingController
            controller?.statusBarStyle = .lightContent
            
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
                        .frame(width:(width-40)/4,height: 30)
                        .minimumScaleFactor(0.3)
                       
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
                        .frame(width:(width-40)/4,height: 30)
                        .minimumScaleFactor(0.3)
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
                        .frame(width:(width-40)/4,height: 30)
                        .minimumScaleFactor(0.3)
                        
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


