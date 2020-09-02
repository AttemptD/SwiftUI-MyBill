//
//  MyCenterView.swift
//  PageView
//
//  Created by Attempt D on 2020/6/22.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct MyCenterView: View {
    @State var scrollViewContentOffset : CGFloat = 0
    @State private var scale: CGFloat = 1.0
    @State var barTitle = "我的"
    @ObservedObject var appData : AppData
    @ObservedObject var mycenterdata : MyInfoData
    @State var gotoEditView = false
    @State var gotoSetting = false
    var body: some View {
        ZStack(alignment:.topTrailing){
            FancyScrollView(title: "我的",
                            headerHeight: height/3,
                            scrollUpHeaderBehavior: .parallax,
                            scrollDownHeaderBehavior: .offset,
                            cornerRadiusNub:15,
                            header: {
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
                                
                                
                                
            }){
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
                                .background(Color.init("MainCellSpacerColor"))
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
                                .background(Color.init("MainCellSpacerColor"))
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
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.top,20)
                    
                    
                }.background(Color.init("MainCellSpacerColor"))
                
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.init("MainCellSpacerColor"))
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("我的",displayMode: .inline)
            .navigationBarHidden(true)
            .onAppear(){
                self.appData.getMyCenterData()
            }
            
            NavigationLink(destination:SettingView(mycenterdata:self.mycenterdata),isActive: self.$gotoSetting){
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
}



