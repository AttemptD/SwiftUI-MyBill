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
    @State var searchBar = true
    @State var cut = false
    @State var updateBill = false
    @State var billdata = Model()

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
                                            .contextMenu(){
                                                Button(action: {
                                                    
                                                    self.updateBill.toggle()
                                                    self.billdata = child
                                                    
                                                }) {
                                                    Text("修改")
                                                    Image(systemName: "pencil")
                                                }
                                                
                                                
                                                Button(action: {
                                                    
                                                    print(item.folderBill.count)
                                                    
                                                    if(item.folderBill.count != 0){
                                                        
                                                        if(item.folderBill.count == 1){
                                                            item.folderBill.remove(at: child.id)
                                                            RealmDB().delete(time: child.time)
                                                            RealmDB().deleteFolder(time: item.folderTime)
                                                            self.folderData.transerBilltype(type:self.folderData.typeChange)
                                                            
                                                        }else{
                                                            
                                                            item.folderBill.remove(at: child.id)
                                                            
                                                            RealmDB().delete(time: child.time)
                                                            
                                                            self.folderData.setFoloderBillData()
                                                            self.folderData.transerBilltype(type:self.folderData.typeChange)
                                                        }
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
                                
                                
                                
                            }
                        }else{
                            //Text("\(getString(time: item.folderTime,min: 5,max: 10))暂无账单")
                        }
                        
                    }
                    .frame(width: width, height:item.open ? .none : 65, alignment: .leading)
                }
            }
            .padding(.top,height >= 812 ? 108 : 84)
            .opacity(self.folderData.folderList.count > 0 ? 1:0)
            
            HStack{
                
                HStack{
                    
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        
                        .frame(width:18,height:18)
                        .foregroundColor(Color.init("transerTime"))
                        .padding(.leading,cut == false ? 20 : 0)
                    
                    if cut == false{
                        MySearchBar(keyboardType: .default, text: $searchText, placeholder:"请输入搜索内容")
                            
                            .frame(height: 40)
                    }
                    
                    
                    
                }.frame(width: cut == false ?  width-100 : width/9 , height: width/9)
                    .background(Color.init("AllViewCircle"))
                    .cornerRadius(90)
                    .padding(.top,height >= 812 ? 54 : 30)
                    .padding(.leading,15)
                
                
                if cut == true{
                    Spacer().frame(width:10)
                }
                
                
                HStack(alignment: .center){
                    
                    if cut == true {
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
                    
                    if cut == false{
                        Image(systemName:"arrow.right.arrow.left")
                            .foregroundColor(.white)
                    }
                    
                }
                    
                .frame(width: cut == false ? width/9 : width - 100 ,height: width/9)
                .background( cut == false ? Color.init("MainThemeColor") : Color.white)
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
            
            All_ViewAnimation().opacity(self.folderData.folderList.count > 0 ? 0:1)
            
            
        }
        .navigationBarTitle("账单")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .onAppear(){
            
            self.folderData.transerBilltype(type:self.folderData.typeChange )
            
            
        }
        .sheet(isPresented: self.$updateBill) {
            
            NewAddBillView(appData:self.appData,folderData: self.folderData ,billData:self.billdata ,OpenType: "修改")
        }
        
    }
}

