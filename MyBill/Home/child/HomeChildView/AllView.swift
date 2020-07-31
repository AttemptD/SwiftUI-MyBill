//
//  AllView.swift
//  pageView
//
//  Created by Attempt D on 2020/6/29.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct AllView: View {
    @ObservedObject var appData : AppData
    @ObservedObject var folderData = FolderData()
    var body: some View {
        
        ScrollView{
        ForEach(folderData.folderList){ item in
            
            VStack{
               
                Text("\(item.folderTime)")
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(Color.orange)
                
                ForEach(item.folderBill){ child in
                    
                    Text("\(child.money)")
                }
            }.frame(width: width, alignment: .leading)
        }
        }.padding(.top,30)
//        ScrollView{
//            ForEach(appData.BillDatas){item in
//
//                NavigationLink(destination:EmptyView()){
//                    VStack(spacing:0){
//
//                        HStack{
//                            Text("¥ \(transer(value:item.money))")
//                                .padding()
//                                .font(.system(size: 28))
//                                .foregroundColor(.black)
//                            Spacer()
//                            Text(item.type)
//                                .padding()
//                                .foregroundColor(item.type == "支出" ? .gray:.orange)
//                        }
//
//
//                        HStack{
//
//                            VStack(spacing:8){
//
//                                HStack{
//                                    Text(item.doWhat)
//                                        .foregroundColor(.black)
//                                        .font(.system(size: 15))
//                                    Spacer()
//                                } .padding(.horizontal)
//
//
//
//                                HStack{
//                                    Text(item.time)
//                                        .foregroundColor(.gray)
//                                        .fontWeight(.light)
//                                    Spacer()
//                                }.padding(.horizontal)
//
//                            }
//                            Spacer()
//
//                            Image(item.type)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 30, height: 30)
//                                .padding(.horizontal)
//
//                        }
//
//
//                    }
//                    .frame(width:width-20,height: height/6,alignment: .topLeading)
//                    .background(Color.white)
//                    .cornerRadius(5)
//                    .shadow(radius: 5)
//                    .padding(.vertical,10)
//                    .padding(.horizontal,20)
//                }
//                .buttonStyle(PlainButtonStyle())
//            }.padding(.top,30)
//        }
        .onAppear(){
            self.appData.refreshData()
            self.folderData.refresh()
        }
        
        
        
    }
}

struct AllView_Previews: PreviewProvider {
    static var previews: some View {
        AllView(appData: AppData())
    }
}
