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
    @ObservedObject var appData : AppData
    
    @State var searchText : String = ""
   
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        ZStack(alignment:.top){
            
            ScrollView(.vertical, showsIndicators: false) {
                FileName(folderData:folderData,appData:appData,searchText :$searchText)
            }
            .padding(.top,height >= 812 ? 108 : 84)
            .opacity(self.folderData.folderList.count > 0 ? 1:0)
            
            SearchBar_all(searchText: $searchText, folderData: folderData)
            
            Text("还没有账单哦，请添加一个吧 ！")
                .offset(y: -height/4)
                .font(.system(size: 15))
                .frame(width: width-40, alignment: .center)
                .padding(.top,height/2.5)
                .opacity(self.folderData.folderList.count > 0 ? 0:1)
            
            
            
        }
        .navigationBarTitle("账单")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .onAppear(){
            
            self.folderData.transerBilltype(type:self.folderData.typeChange )
           
            
        }
        
        
    }
}

struct FileName: View {
    @ObservedObject var folderData : FolderData
    @ObservedObject var appData : AppData
    @Binding var searchText : String
    @State var searchBar = true
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        if #available(iOS 14.0, *) {
            LazyVStack {
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
                                ZStack{
                                    Chart(data:item.lineData)
                                        .chartStyle( LineChartStyle(.quadCurve, lineColor: .white, lineWidth: 2)
                                    )
                                        .frame(width: item.open ? 0 : width - 170, height: item.open ? 0 : 50,alignment:.center)
                                        .padding(.leading,60)
                                        .opacity(item.open ? 0:1)
                                    
                                    Text("暂无账单")
                                        .foregroundColor(.white)
                                        .bold()
                                        .opacity(item.haveData ? 0 : 1)
                                    
                                }
                            )
                                .onTapGesture{
                                    withAnimation(.spring()){
                                        if item.haveData {
                                            self.folderData.transerStatus(folder:item)
                                        }
                                        
                                    }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.spring()){
                                    self.folderData.transerStatus(folder:item)
                                    
                                }
                            }) {
                                
                                Image(systemName: item.imagename)
                                
                            }
                                
                            .frame(height: 55, alignment: .center)
                                
                            .padding(.trailing,30)
                            .disabled(!item.haveData)
                            
                            
                        }
                        
                        if item.haveData {
                            if item.open {
                                
                                ChildContent(item: item, folderData: self.folderData, appData: self.appData)
                                
                                
                                
                            }
                        }else{
                            
                        }
                        
                    }
                    .frame(width: width, height:item.open ? .none : 65, alignment: .leading)
                }
            }
        } else {
            // Fallback on earlier versions
        }

        
        
    }
}

struct ChildContent: View {
    let item :Folder
    @State var updateBill = false
    @State var billdata = Model()
    @State var billdata_money = ""
    @ObservedObject var folderData : FolderData
    @ObservedObject var appData : AppData
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ForEach(item.folderBill){ child in
            
            HStack(alignment:.top){
                VStack{
                    Circle().frame(width: 20, height:20 )
                        .foregroundColor(self.colorScheme == .dark ? Color.init("MainCellSpacerColor_dark") :Color.init("AllViewCircle"))
                        .overlay(Circle().frame(width: 5, height: 5)
                            .foregroundColor(self.colorScheme == .dark ? Color.gray: Color.init("transerTime")))
                    
                    Spacer().frame(height:0)
                    
                    if(child.id != self.item.folderBill.count-1){
                        
                        Divider().frame(width:1, height: 110)
                            .background(self.colorScheme == .dark ? Color.gray :Color.init("AllViewCircle"))
                        
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
                    .background(self.colorScheme == .dark ? Color.init("MainCellSpacerColor_dark") :Color.init("AllViewCircle"))
                    .cornerRadius(15)
                    .contextMenu(){
                        Button(action: {
                            
                            self.updateBill.toggle()
                            self.billdata = child
                            self.billdata_money = String(child.money)
                           
                            
                        }) {
                            Text("修改")
                            Image(systemName: "pencil")
                        }
                        
                        
                        Button(action: {
                            
                           
                                
                                if(self.item.folderBill.count == 1){
                                    self.item.folderBill.remove(at: child.id)
                                    RealmDB().delete(time: child.time)
                                    RealmDB().deleteFolder(time: self.item.folderTime)
                                    self.folderData.transerBilltype(type:self.folderData.typeChange)
                                    
                                }else{
                                    
                                    self.item.folderBill.remove(at: child.id)
                                    
                                    RealmDB().delete(time: child.time)
                                    
                                    self.folderData.setFoloderBillData()
                                    self.folderData.transerBilltype(type:self.folderData.typeChange)
                                    
                                    
                                }
                            
                            
                        }) {
                            Text("删除")
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                }
                .frame(height: 100)
                
            }
            
        }
        .id(UUID())
        .padding(.leading,80)
        
        .sheet(isPresented: self.$updateBill) {
            
            NewAddBillView(appData:self.appData,folderData: self.folderData ,billData:self.$billdata ,OpenType: "修改",editMoney:self.$billdata_money)
        }
    }
}

struct SearchBar_all: View {
    @State var cut = false
    @Binding var searchText : String
    @ObservedObject var folderData : FolderData
    @Environment(\.colorScheme) var colorScheme
    @State var color = "AllViewCircle"
    var body: some View {
        HStack{
            
            HStack{
                
                Image(systemName: "magnifyingglass")
                    .resizable()
                    
                    .frame(width:18,height:18)
                    .foregroundColor(self.colorScheme == .dark ? Color.gray: Color.init("transerTime"))
                    .padding(.leading,cut == false ? 20 : 0)
                
                if cut == false{
                    MySearchBar(keyboardType: .default, text: $searchText, placeholder:"请输入搜索内容")
                        .frame(height: 40)
                }
                
                
                
            }.frame(width: cut == false ?  width-100 : width/9 , height: width/9)
                .background(self.colorScheme == .dark ? Color.init("MainCellSpacerColor_dark") :Color.init("AllViewCircle"))
                .cornerRadius(90)
                .padding(.top,height >= 812 ? 54 : 30)
                .padding(.leading,15)
            
            
            if cut == true{
                Spacer().frame(width:10)
            }
            
            
            HStack(alignment: .center){
                
                if cut {
                    Spacer()
                    Button(action: {
                        
                        withAnimation(.spring()){
                            self.cut = false
                        }
                        if self.folderData.typeChange != "全部"{
                            self.folderData.transerBilltype(type: "全部")
                        }
                    }) {
                        Text("全部")
                            .frame(width: width/7, height: width/11, alignment: .center)
                            .foregroundColor(.white)
                            .background(folderData.typeChange == "全部" ? Color.init("MainThemeColor") :Color.init("AllViewCircle"))
                            .cornerRadius(15)
                        
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()){
                            self.cut = false
                        }
                        if self.folderData.typeChange != "支出"{
                            self.folderData.transerBilltype(type: "支出")
                        }
                    }) {
                        Text("支出")
                            .frame(width: width/7, height: width/11, alignment: .center)
                            .foregroundColor(.white)
                            .background(folderData.typeChange == "支出" ? Color.init("MainThemeColor") :Color.init("AllViewCircle"))
                            .cornerRadius(15)
                    }
                    Spacer()
                    Button(action: {
                        
                        withAnimation(.spring()){
                            self.cut = false
                        }
                        if self.folderData.typeChange != "收入"{
                            self.folderData.transerBilltype(type: "收入")
                        }
                    }) {
                        Text("收入")
                            .frame(width: width/7, height: width/11, alignment: .center)
                            .foregroundColor(.white)
                            .background(folderData.typeChange == "收入" ? Color.init("MainThemeColor") :Color.init("AllViewCircle"))
                            .cornerRadius(15)
                    }
                    Spacer()
                }
                
                if !cut {
                    Image(systemName:"arrow.right.arrow.left")
                        .foregroundColor(.white)
                }
                
            }
                
            .frame(width: !cut ? width/9 : width - 100 ,height: width/9)
            .background( !cut ? Color.init("MainThemeColor") : self.colorScheme == .dark ? Color.black: Color.white)
            .cornerRadius(90)
            .overlay(
                RoundedRectangle(cornerRadius: 90)
                    .stroke(Color.init("MainThemeColor"), lineWidth: cut == true ? 1 : 0 )
                    .animation(.linear)
                
            )
                
                .padding(.top,height >= 812 ? 54 : 30)
                .onTapGesture {
                    withAnimation(.spring()){
                        self.cut = true
                    }
                    
            }
            
            
        }
        .frame(width:width, height: height >= 812 ? 88 : 64)
        .background(Color.clear)
        
    }
}
