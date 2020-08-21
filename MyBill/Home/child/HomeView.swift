//
//  HomeView.swift
//  pageView
//
//  Created by Attempt D on 2020/6/29.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI
import UIKit


struct HomeView: View {
    @State var scrollViewContentOffset : CGFloat = 0
    @State private var scale: CGFloat = 1.0
    @State var barTitle = "主页"
    @State var updateBill = false
    @ObservedObject var appData : AppData
    @State var billdata = Model()
    @ObservedObject var folderData : FolderData
    @ObservedObject var mycenterdata : MyInfoData
    var body: some View {
        
        ZStack(alignment:.topTrailing){
            
            Image(uiImage: ImageTranser().DataToImage(data: mycenterdata.background))
                .resizable()
                .scaledToFill()
                .frame(width: width, height:height/3)
                .clipped()
                .blur(radius: scrollViewContentOffset >= 0 ? 0 :  -scrollViewContentOffset/2,opaque:true)
                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                .scaleEffect(-scrollViewContentOffset < 0 ? 1 + scrollViewContentOffset / 200 : 1)
                .overlay(
                    
                    VStack{
                        
                        HStack{
                            Text(appData.TodayEarning - appData.TodayPay < 0 ? "支出" : "收入")
                                .bold()
                                .font(.system(size: 20))
                                
                                .foregroundColor(Color.init("FontColor"))
                            
                            Spacer()
                            
                            Text(appData.TodayEarning - appData.TodayPay < 0 ? "¥\(transer(value: appData.TodayPay - appData.TodayEarning))" : "¥\(transer(value: appData.TodayEarning - appData.TodayPay))")
                                
                                .font(.system(size: 25))
                                .foregroundColor(Color.init("FontColor"))
                            
                            
                            
                        }
                        .padding(.bottom,50)
                        .foregroundColor(.black)
                        
                    }
                        
                    .frame(width: width-60, height: height/3.5,alignment: .center)
                    
            )
                
                .offset(x: 0, y:-scrollViewContentOffset <= 0 ? 0 : scrollViewContentOffset)
                .animation(.easeInOut(duration: 0.3))
            
            TrackableScrollView(axis: .vertical, showIndicators: false, contentOffset: $scrollViewContentOffset){
                Spacer().frame(width:width, height: height/3)
                    .animation(.none)
                
                
                VStack{
                    Image(uiImage:ImageTranser().DataToImage(data: mycenterdata.headerIco))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60, alignment: .center)
                        .clipped()
                        .cornerRadius(50)
                    
                    Text(mycenterdata.name)
                        .bold()
                        .foregroundColor(Color.init("FontColor"))
                    
                    HStack(alignment: .center){
                        
                        HStack{
                            Image("收入-1")
                                .resizable()
                                .frame(width: 35, height: 35)
                            VStack(alignment:.leading){
                                Text("\(transer(value: appData.TodayEarning))元")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundColor(Color.init("FontColor"))
                                Text("收入")
                                    .font(.system(size: 11))
                                    .fontWeight(.thin)
                                
                            }
                        }
                        
                        Spacer()
                        
                        HStack{
                            Image("支出-1")
                                .resizable()
                                .frame(width: 35, height: 35)
                            
                            VStack(alignment:.leading){
                                Text("\(transer(value: appData.TodayPay))元")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundColor(Color.init("FontColor"))
                                Text("支出")
                                    .font(.system(size: 11))
                                    .fontWeight(.thin)
                                
                            }
                        }
                    }.padding(.horizontal,width/10)
                        .frame(width: width-60,  alignment: .center)
                    
                    
                }
                .frame(width: width-60, height: 190, alignment: .center)
                .background(Color.white)
                .shadow(radius: 10)
                .cornerRadius(10)
                .offset(x:0,y:-height/8)
                .animation(.none)
                
                HStack{
                    Text(appData.TodayBill.count == 0 ? "往期的账单" : "今天的账单")
                        .font(.system(size:20))
                        .bold()
                        .foregroundColor(Color.init("FontColor"))
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color.init("FontColor"))
                    }
                } .frame(width: width-60,  alignment: .center)
                    .offset(x:0,y:-height/10)
                    .animation(.none)
                
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
                                    
                                    .foregroundColor(Color.init("FontColor"))
                                
                                Text(item.blurTime)
                                    .foregroundColor(.gray)
                                    .fontWeight(.light)
                                    .font(.system(size:14))
                                
                            }
                            .padding(.vertical,15)
                            .frame(width: (width-60)/2-10, alignment: .center)
                                
                            .background(Color.white)
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
                                    
                                    if(self.appData.TodayBill.count != 0){
                                        self.appData.TodayBill.remove(at: item.id)
                                    }else{
                                        self.appData.Bill_ten.remove(at:item.id)
                                    }
                                    
                                    DispatchQueue.main.async {
                                        
                                        
                                        RealmDB().delete(time: item.time)
                                        self.appData.refreshData()
                                        self.folderData.setFoloderBillData()
                                    }
                                    
                                }) {
                                    Text("删除")
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                
                            }
                           
                            
                        }
                        .frame(width: width-60, height: 65, alignment:Double(item.id).truncatingRemainder(dividingBy: 2) == 0 ? .leading:.trailing)
                        .shadow(radius: 5)
                        .animation(.none)
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                }.id(UUID())
                    .offset(x:0,y:-height/20)
                
            }
            
            
            
            MyNavigationBar(scrollViewContentOffset: self.$scrollViewContentOffset, middle: self.$barTitle, right: "透明")
            
            
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.init("MainCellSpacerColor"))
        .navigationBarTitle("主页",displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear(){
            self.appData.refreshData()
            
        }
        .sheet(isPresented: self.$updateBill) {
            
            NewAddBillView(appData:self.appData,folderData: self.folderData ,billData:self.billdata ,OpenType: "修改")
        }
        
        
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
