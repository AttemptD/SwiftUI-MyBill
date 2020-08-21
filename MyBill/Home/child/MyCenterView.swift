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
    var body: some View {
        ZStack(alignment:.top){
            
            Image(uiImage: ImageTranser().DataToImage(data: mycenterdata.headerIco))
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height/3)
                .clipped()
                
                .blur(radius: scrollViewContentOffset >= 0 ? 4 :  -scrollViewContentOffset/2 + 4,opaque:true)
                 .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                .scaleEffect(-scrollViewContentOffset < 0 ? 1 + scrollViewContentOffset / 200 : 1)
                .overlay(Image(uiImage: ImageTranser().DataToImage(data: mycenterdata.headerIco))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85, alignment: .center)
                    .clipped()
                    .cornerRadius(50))
               
                .offset(x: 0, y:-scrollViewContentOffset <= 0 ? 0 : scrollViewContentOffset)
            
            TrackableScrollView(axis: .vertical, showIndicators: false,contentOffset: $scrollViewContentOffset){
                
                
                Spacer().frame(width:width, height: height/3)
                
                        
                
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
                
                
             
//                HStack(alignment:.center){
//                        Image("资料修改")
//                            .resizable().frame(width: 32, height: 32)
//                            .padding(.leading,10)
//                    Spacer().frame(width:10)
//                        Text("资料修改")
//                            .font(.system(size: 15))
//                            .fontWeight(.light)
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .padding(.trailing,10)
//
//                    }
//                .frame(width: width - 20, height: 50,alignment: .leading)
//                        .background(Color.white)
//                .cornerRadius(10)
                
//                HStack(alignment:.center){
//                        Image("设置")
//                            .resizable().frame(width: 30, height: 30)
//                            .padding(.leading,10)
//                    Spacer().frame(width:10)
//                        Text("设置")
//                            .font(.system(size: 15))
//                            .fontWeight(.light)
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .padding(.trailing,10)
//
//                    }
//                .frame(width: width - 20, height: 50,alignment: .leading)
//                        .background(Color.white)
//                .cornerRadius(10)
                
                
            }
            
            MyNavigationBar(scrollViewContentOffset: self.$scrollViewContentOffset, middle: self.$barTitle, right: "ellipsis")
            
        }
        .background(Color.init("MainCellSpacerColor"))
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle("我的",displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear(){
            self.appData.getMyCenterData()
        }
        
    }
}



