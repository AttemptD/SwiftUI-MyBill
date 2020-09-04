//
//  BackgroundEdit.swift
//  MyBill
//
//  Created by Attempt D on 2020/9/1.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct BackgroundEdit: View {
    @ObservedObject var mycenterdata : MyInfoData
    @State var page = 0
    @State var changeImage = false
    @State var seletImage = ""
    @State var showSeletImage = false
    @State var diybackgroundImage : UIImage?
    @Environment(\.presentationMode) var persentationMode
    let data = ["IMG_0090","MyImageBack","background2","background"]
    var body: some View {
        ZStack(alignment:.topLeading){
            ZStack(alignment: .center){
                Previews_Home(mycenterdata: self.mycenterdata,changeImage:self.$changeImage,seletImage:$seletImage, diybackgroundImage: self.$diybackgroundImage)
                    .edgesIgnoringSafeArea(.all)
                
                ZStack(alignment:.bottom){
                    VStack{
                        
                        Pager(page: self.$page,
                              data: self.data,
                              id: \.self) {
                                
                                self.pageView("\($0)")
                                
                        }
                            
                        .itemSpacing(-30)
                        .itemAspectRatio(0, alignment: .center)
                        .overlay(Text("当前主页背景以上图所示").foregroundColor(Color.init("FontColor"))
                        .fontWeight(.light)
                        .offset(y:-160))
                        
                        
                    }.padding(.top,width/3)
                    
                    HStack(spacing:20){
                        Button(action: {
                            self.showSeletImage.toggle()
                            
                        }) {
                            HStack{
                                
                                Text("自定义")
                                Image(systemName: "photo.fill")
                                    .foregroundColor(Color.init("MainThemeColor"))
                            }.frame(width: width/3, height: 40, alignment: .center)
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.init("MainThemeColor"),.white]), startPoint: .bottomLeading, endPoint: .topTrailing))
                                
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            
                        }
                            
                        .sheet(isPresented:  $showSeletImage) {
                            ImagePicker(image: self.$diybackgroundImage, isPresented: self.$showSeletImage)
                        }
                        
                        Button(action: {
                            
                            if self.diybackgroundImage != nil{
                                RealmDB().insertMyInfo(header: self.mycenterdata.headerIco,
                                                       background: ImageTranser().ImageToData(image: self.diybackgroundImage!),
                                                       name: self.mycenterdata.name)
                            }else{
                                RealmDB().insertMyInfo(header: self.mycenterdata.headerIco,
                                                       background: ImageTranser().ImageToData(image: UIImage.init(named: self.seletImage) ??
                                                        ImageTranser().DataToImage(data: self.mycenterdata.background)),
                                                       name: self.mycenterdata.name)
                            }
                            
                            self.mycenterdata.getMyInfo()
                            self.persentationMode.wrappedValue.dismiss()
                            
                        }) {
                            HStack{
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(Color.init("MainThemeColor"))
                                
                                Text("完成")
                            }.frame(width: width/3, height: 40, alignment: .center)
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [.white, Color.init("MainThemeColor")]), startPoint: .bottomLeading, endPoint: .topTrailing))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            
                        }
                        
                    }.padding(.bottom,width/4)
                }
                
                
            }
            .onAppear(){
                let controller = UIApplication.shared.windows[0].rootViewController as? MyHontingController
                controller?.statusBarStyle = .lightContent
            }
            Button(action: {
                self.persentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .scaleEffect(1.2)
                    .foregroundColor(.white)
                    .padding(.leading,25)
                    .padding(.top,10)
                
            }.frame(width: 50, height: 30, alignment: .center)
                .contentShape(Rectangle())
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
    func pageView(_ page: String) -> some View {
        ZStack {
            
            Image("\(page)")
                .resizable()
                .scaledToFill()
                .frame(width:width - 40, height: 260, alignment: .center)
                .clipped()
                .shadow(radius: 5)
                .onTapGesture {
                    self.changeImage = true
                    self.seletImage = page
            }
            
            
        }
        .cornerRadius(10)
        
    }
}

struct BackgroundEdit_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundEdit(mycenterdata: MyInfoData())
    }
}
struct Previews_Home: View {
    @ObservedObject var mycenterdata : MyInfoData
    @Binding var changeImage : Bool
    @Binding var seletImage : String
    @Binding var diybackgroundImage : UIImage?
    var body: some View {
        FancyScrollView(title: "主页",
                        headerHeight: height/3,
                        scrollUpHeaderBehavior: .parallax,
                        scrollDownHeaderBehavior: .offset,
                        cornerRadiusNub:15,
                        showTitle:false,
                        header: { self.changeImage == true ? Image(seletImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill):
                            Image(uiImage:(self.diybackgroundImage != nil ? diybackgroundImage : ImageTranser().DataToImage(data: mycenterdata.background)) ?? ImageTranser().DataToImage(data: mycenterdata.background))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
        }) {
            
            Text("")
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.init("MainCellSpacerColor"))
        
        
    }
}
