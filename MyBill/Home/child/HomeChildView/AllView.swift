//
//  AllView.swift
//  pageView
//
//  Created by Attempt D on 2020/6/29.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct AllView: View {
    @ObservedObject var folderData : FolderData
    @State var searchText : String = ""
    @State var searchBar = true
    var body: some View {
        
        
        ZStack(alignment:.top){
            
            
            
            ScrollView(.vertical, showsIndicators: false){
                ForEach(folderData.folderList){ item in
                    
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
                                
                                
                                
                            }.frame(width:item.open ? 55 : width - 80,height: 55, alignment: item.open ? .center:.leading)
                                .foregroundColor(.white)
                                .background(Color.init("MainThemeColor"))
                                .cornerRadius(15)
                                .padding(.leading,30)
                            
                            
                            Spacer()
                            
                            
                            
                            Button(action: {
                                
                                withAnimation(.spring()){
                                    
                                    self.folderData.transerStatus(folder:item)
                                    
                                }
                                
                                
                            }) {
                                
                                Image(systemName: item.imagename)
                            }.frame(height: 55, alignment: .center)
                                
                                
                                .padding(.trailing,20)
                            
                        }
                        
                        
                        
                        
                        ForEach(item.folderBill){ child in
                            
                            HStack(alignment:.top){
                                VStack{
                                    Circle().frame(width: 20, height:20 )
                                        .foregroundColor(Color.init("AllViewCircle"))
                                        .overlay(Circle().frame(width: 5, height: 5)
                                            .foregroundColor(.black))
                                    
                                    Spacer().frame(height:0)
                                    
                                    if(child.id != item.folderBill.count-1){
                                        
                                        Divider().frame(width:1, height: 100)
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
                                        Spacer()
                                        Text("¥\(transer(value: child.money))")
                                            .padding(.trailing,20)
                                    }
                                    .frame(width: width-140, height: 70, alignment: .leading)
                                    .background(Color.init("AllViewCircle"))
                                    .cornerRadius(15)
                                    
                                }.frame(height: 100)
                                
                            }
                            .frame(height: item.open ? 100 : 0)
                            
                        }
                        .opacity(item.open ? 1 : 0)
                        .padding(.leading,80)
                        
                        
                        
                    }.frame(width: width, alignment: .leading)
                }
                
            }
            .padding(.top,height >= 812 ? 88 : 64)
            
            HStack{
                 SearchBar(text: $searchText,clean: $searchBar)
                    .animation(.default)
            } .frame(width: width,height: height >= 812 ? 88 : 64,alignment: .bottom)
            
        }
        .navigationBarTitle("账单")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .onAppear(){
            
            self.folderData.refresh()
            
        }
        
        
        
    }
}

