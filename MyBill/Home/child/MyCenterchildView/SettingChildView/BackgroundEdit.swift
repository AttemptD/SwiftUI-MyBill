//
//  BackgroundEdit.swift
//  MyBill
//
//  Created by Attempt D on 2020/9/1.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct BackgroundEdit: View {
    @ObservedObject var mycenterdata : MyInfoData
    var body: some View {
        Previews_Home(mycenterdata: self.mycenterdata)
            .frame(width: width/2, height: height/2, alignment: .center)
    }
}

struct BackgroundEdit_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundEdit(mycenterdata: MyInfoData())
    }
}
struct Previews_Home: View {
    @ObservedObject var mycenterdata : MyInfoData
    var body: some View {
        FancyScrollView(title: "主页",
                        headerHeight: height/3,
                        scrollUpHeaderBehavior: .parallax,
                        scrollDownHeaderBehavior: .offset,
                        cornerRadiusNub:15,
                        showTitle:false,
                        header: { Image(uiImage:ImageTranser().DataToImage(data: mycenterdata.background)).resizable()
                            .aspectRatio(contentMode: .fill)
                            .overlay(
                                VStack{
                                    HStack{
                                        Text("收入")
                                            .bold()
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.init("FontColor"))
                                        
                                        Spacer()
                                        
                                        Text("¥0")
                                            .font(.system(size: 25))
                                            .foregroundColor(Color.init("FontColor"))
                                    }
                                    .padding(.bottom,50)
                                    .foregroundColor(.black)
                                    
                                }
                                    
                                .frame(width: width-60, height: height/3.5,alignment: .center)
                                
                            )
                            
                            
        }) {
            
            Text("")
//            VStack{
//                VStack{
//                    Image("MyImageBack")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 60, height: 60, alignment: .center)
//                        .clipped()
//                        .cornerRadius(50)
//                        .blur(radius: 10)
//
//                    Text("Attempt")
//                        .bold()
//                        .foregroundColor(Color.init("FontColor"))
//                        .blur(radius: 10)
//
//                    HStack(alignment: .center){
//
//                        HStack{
//                            Image("收入-1")
//                                .resizable()
//                                .frame(width: 35, height: 35)
//                            VStack(alignment:.leading){
//                                Text("\(0)元")
//                                    .font(.system(size: 16))
//                                    .bold()
//                                    .foregroundColor(Color.init("FontColor"))
//                                Text("收入")
//                                    .font(.system(size: 11))
//                                    .fontWeight(.thin)
//
//                            }
//                        }
//
//                        Spacer()
//
//                        HStack{
//                            Image("支出-1")
//                                .resizable()
//                                .frame(width: 35, height: 35)
//
//                            VStack(alignment:.leading){
//                                Text("\(0)元")
//                                    .font(.system(size: 16))
//                                    .bold()
//                                    .foregroundColor(Color.init("FontColor"))
//                                Text("支出")
//                                    .font(.system(size: 11))
//                                    .fontWeight(.thin)
//
//                            }
//                        }
//                    }.padding(.horizontal,width/10)
//                        .frame(width: width-60,  alignment: .center)
//
//
//                }
//                .frame(width: width-60, height: 190, alignment: .center)
//                .background(Color.white)
//                .shadow(radius: 10)
//                .cornerRadius(10)
//                .offset(x:0,y:-height/8)
//                .animation(.none)
//
//                HStack{
//                    Text("今天的账单")
//                        .font(.system(size:20))
//                        .bold()
//                        .foregroundColor(Color.init("FontColor"))
//                    Spacer()
//                    Button(action: {
//
//                    }) {
//                        Image(systemName: "ellipsis")
//                            .foregroundColor(Color.init("FontColor"))
//                    }
//                } .frame(width: width-60,  alignment: .center)
//                    .offset(x:0,y:-height/12)
//                    .animation(.none)
//
//
//
//
//            } .background(Color.init("MainCellSpacerColor"))
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.init("MainCellSpacerColor"))
            .navigationBarTitle("主页").navigationBarHidden(true)
            
    }
}
