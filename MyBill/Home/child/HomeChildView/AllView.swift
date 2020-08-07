//
//  AllView.swift
//  pageView
//
//  Created by Attempt D on 2020/6/29.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI
import Charts

struct AllView: View {
    @ObservedObject var folderData : FolderData
    @State var searchText : String = ""
    @State var searchBar = true
    var body: some View {
        
        ZStack(alignment:.top){
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(folderData.folderList.filter{ value in
                    self.searchText.isEmpty ? true :value.folderTime.lowercased().contains(self.searchText.lowercased())
                }){ item in
                    VStack(alignment:.leading){
                        HStack{
                            VStack(spacing:0){
                                
                                Text("\(getString(time: item.folderTime,min: 5,max: 7))")
                                    .bold()
                                    .fontWeight(.medium)
                                    .lineSpacing(2)
                                    .frame(width: 55, height: 20, alignment: .center)
                                
                                Text("\(getString(time: item.folderTime,min: 8,max: 10))")
                                    .bold()
                                    .lineSpacing(2)
                                    .frame(width: 55, height: 20, alignment: .center)
                                
                                
                            }
                            .frame(width:item.open ? 55 : width - 100,height: 55, alignment: item.open ? .center:.leading)
                            .foregroundColor(.white)
                            .background(Color.init("MainThemeColor"))
                            .cornerRadius(15)
                            .padding(.leading,30)
                            .overlay(
                                
                                Chart(data:item.lineData)
                                    .chartStyle( LineChartStyle(.quadCurve, lineColor: .white, lineWidth: 2)
                                )
                                    .frame(width: item.open ? 0 : width - 170, height: item.open ? 0 : 50,alignment:.center)
                                    .padding(.leading,60)
                                    .opacity(item.open ? 0:1)
                            )
                            
                            Spacer()
                            
                            Button(action: {
                                
                                withAnimation(.spring()){
                                    
                                    self.folderData.transerStatus(folder:item)
                                    
                                }
                                
                            }) {
                                
                                Image(systemName: item.imagename)
                            }.frame(height: 55, alignment: .center)
                                .padding(.trailing,30)
                            
                            
                            
                        }
                        
                        if item.open {
                            ForEach(item.folderBill){ child in
                                
                                HStack(alignment:.top){
                                    VStack{
                                        Circle().frame(width: 20, height:20 )
                                            .foregroundColor(Color.init("AllViewCircle"))
                                            .overlay(Circle().frame(width: 5, height: 5)
                                                .foregroundColor(Color.init("transerTime")))
                                        
                                        Spacer().frame(height:0)
                                        
                                        if(child.id != item.folderBill.count-1){
                                            
                                            Divider().frame(width:1, height: 110)
                                                .background(Color.init("AllViewCircle"))
                                            
                                        }
                                        
                                    }
                                    .frame(height: 120,alignment: .topLeading)
                                    
                                    VStack(alignment:.leading){
                                        Text("\(String(child.time.suffix(8)))")
                                            .foregroundColor(.gray)
                                            .fontWeight(.thin)
                                            .frame(width: 100, alignment: .leading)
                                        
                                        
                                        HStack{
                                            Image("\(child.type)")
                                                .resizable()
                                                .frame(width: 35, height: 35, alignment: .center)
                                                .padding(.leading,10)
                                            
                                            Text(child.doWhat)
                                                .font(.system(size: 14))
                                            Spacer()
                                            Text("¥\(transer(value: child.money))")
                                                .padding(.trailing,20)
                                        }
                                        .frame(width: width-140, height: 70, alignment: .leading)
                                        .background(Color.init("AllViewCircle"))
                                        .cornerRadius(15)
                                        
                                    }.frame(height: 100)
                                    
                                }
                                
                                
                            }
                            .padding(.leading,80)
                        }
                        
                    }.frame(width: width, height:item.open ? .none : 65, alignment: .leading)
                }
            }
            .padding(.top,height >= 812 ? 108 : 84)
            
            
            HStack{
                
                HStack{
                    
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        
                        .frame(width:18,height:18)
                        .foregroundColor(Color.init("transerTime"))
                        .padding(.leading,20)
                    
                    
                    MySearchBar(keyboardType: .default, text: $searchText, placeholder:"请输入搜索内容")
                        
                        .frame(height: 40)
                    
                    
                }.frame(width: width-100, height: 50)
                    .background(Color.init("AllViewCircle"))
                    .cornerRadius(90)
                    .padding(.top,height >= 812 ? 54 : 30)
                    .padding(.leading,15)
                
                
                
                Button(action: {
                    
                }) {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.init("transerTime"))
                        .padding(.top,height >= 812 ? 54 : 30)
                        .overlay(
                            Image(systemName: "line.horizontal.3.decrease")
                                .resizable()
                                .frame(width:18,height: 18)
                                .padding(.top,height >= 812 ? 54 : 30)
                                .foregroundColor(.white)
                            
                            
                    )
                }
                
            }
            .frame(width:width, height: height >= 812 ? 88 : 64)
            .background(Color.clear)
        }
        .navigationBarTitle("账单")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .onAppear(){
            
            self.folderData.refresh()
            
        }
        
        
    }
}

