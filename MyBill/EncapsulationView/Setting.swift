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
    var body: some View {
        
        ZStack(alignment:.topLeading){
            FancyScrollView(title: "设置",
                            headerHeight: 200,
                            scrollUpHeaderBehavior: .parallax,
                            scrollDownHeaderBehavior: .offset,
                            showTitle: true,
                            header: { Image("Setting").resizable().scaledToFill() }) {
                                VStack{
                                    ScrollView{
                                        ForEach(setting.settingData){item in
                                            
                                            NavigationLink(destination:SettingChildMainView(settingModel: item,mycenterdata:self.mycenterdata)){
                                                HStack{
                                                    Image(item.seleterIcon)
                                                    Text(item.seleterName)
                                                    Spacer()
                                                    Image(systemName: "chevron.right")
                                                }.padding(.horizontal,20)
                                                    .frame(width: width-40, height: 50, alignment: .leading)
                                                    .contentShape(Rectangle())
                                            }.buttonStyle(PlainButtonStyle())
                                            
                                            
                                        }
                                    }
                                    
                                }
                                .frame(width: width-40,alignment: .center)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                
                                
            }.background(Color.init("MainCellSpacerColor"))
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                self.persentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .scaleEffect(1.1)
                    .foregroundColor(.black)
                    .padding(.leading,25)
                    .padding(.top,10)
                
            }
            
        }
        
    }
}
