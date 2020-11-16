//
//  Setting.swift
//  MyBill
//
//  Created by Attempt D on 2020/8/13.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var setting = SettingData()
    @ObservedObject var mycenterdata : MyInfoData
    @Environment(\.presentationMode) var persentationMode
    @Environment(\.colorScheme) var colorScheme
    @State var window: UIWindow
    var body: some View {
        
        ZStack(alignment:.topLeading){
            FancyScrollView(title: "设置",
                            headerHeight: 200,
                            scrollUpHeaderBehavior: .parallax,
                            scrollDownHeaderBehavior: .offset,
                            cornerRadiusNub:15,
                            showTitle: true,
                            header: { Image(colorScheme == .dark ? "Setting_dark" : "Setting").resizable().scaledToFill() })
            {
                
                VStack{
                    Spacer().frame(height:20)
                    VStack{
                        ScrollView{
                            ForEach(colorScheme == .dark ? setting.settingData_dark: setting.settingData){item in
                                
                                NavigationLink(destination:SettingChildMainView(settingModel: item,mycenterdata:self.mycenterdata,window: self.window)){
                                    HStack{
                                        Image(item.seleterIcon)
                                            .resizable()
                                            .scaledToFit()
                                            .scaleEffect(0.7)
                                        Text(item.seleterName)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .padding(.horizontal,15)
                                    .frame(width: width-40, height: 40, alignment: .center)
                                    .contentShape(Rectangle())
                                    
                                    
                                }.buttonStyle(PlainButtonStyle())
                            }
                            
                        }.background(self.colorScheme == .dark ? Color.init("MainCellSpacerColor_dark") : Color.white)
                        
                    }
                    .padding(.vertical,15)
                        
                    .frame(width: width-40,alignment: .center)
                    .background(self.colorScheme == .dark ? Color.init("MainCellSpacerColor_dark") : Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
               
                .background(colorScheme == .dark ? Color.black : Color.init("SettingColor") )
                
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(colorScheme == .dark ? Color.black : Color.init("SettingColor") )
            .navigationBarTitle("设置")
            .navigationBarHidden(true)
        
            
            Button(action: {
                self.persentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .scaleEffect(1.2)
                    .foregroundColor(colorScheme == .dark ? .white :.black)
                    .padding(.leading,25)
                    .padding(.top,10)
                
            }.frame(width: 50, height: 30, alignment: .center)
                .contentShape(Rectangle())
            
        }.onAppear(){
            
            if self.colorScheme != .dark{
                let controller = UIApplication.shared.windows[0].rootViewController as? MyHontingController
                controller?.statusBarStyle = .darkContent
            }
            
        }
        
    }
}
