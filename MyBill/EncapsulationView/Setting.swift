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
                                    Spacer().frame(height:20)
                                VStack{
                                    ScrollView{
                                        ForEach(setting.settingData){item in
                                            
                                            NavigationLink(destination:SettingChildMainView(settingModel: item,mycenterdata:self.mycenterdata)){
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
                                    }
                                    
                                }
                                .padding(.vertical,15)
                                .frame(width: width-40,alignment: .center)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                } .frame(width: width,alignment: .center)
                                .background(Color.init("SettingColor"))
                                
                                
            } .background(Color.init("SettingColor"))
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                self.persentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .scaleEffect(1.2)
                    .foregroundColor(.black)
                    .padding(.leading,25)
                    .padding(.top,10)
                
            }.frame(width: 50, height: 30, alignment: .center)
            .contentShape(Rectangle())
            
        }.onAppear(){
            let controller = UIApplication.shared.windows[0].rootViewController as? MyHontingController
                       controller?.statusBarStyle = .darkContent
        }
        
    }
}
