//
//  SetInfoView.swift
//  MyBill
//
//  Created by Attempt D on 2020/8/13.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct SetInfoView: View {
    @State var header : UIImage?
    @State var username = ""
    @State var selectImage = false
    @State var showtips = false
    @ObservedObject var mycenterdata : MyInfoData
    var body: some View {
        
        ZStack(alignment:.bottom){
            VStack(alignment:.leading,spacing: 10){
                
                Text("设置个人信息")
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                
                Text("给自己设置一个头像和用户名吧")
                    .font(.system(size: 12))
                    .fontWeight(.light)
                
                Spacer().frame(height:50)
                Image(uiImage: header ?? UIImage(named: "MyImageBack")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(90)
                    .clipped()
                    .overlay(
                        
                        
                        HStack{
                            Image(systemName: "camera.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.white)
                            
                            
                        }.frame(width: 68, height: 20, alignment: .center)
                            .background(DiyShape(tl: 0, tr: 0, bl: 360, br: 360).fill(Color.init("HeaderIconBack")) )
                            .padding(.top,60)
                        
                        
                        
                )
                    
                    .onTapGesture {
                        self.selectImage.toggle()
                }
                Spacer().frame(height:20)
                
                HStack{
                    TextField("设置一个用户名呗", text: $username)
                        .padding(.leading,10)
                        .frame( height: 40)
                    
                    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.init("MainThemeColor"), lineWidth: 1 )
                        .animation(.linear)
                ).padding(.trailing,40)
                
            }
            .padding([.leading,.top],25)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .sheet(isPresented:  $selectImage) {
                ImagePicker(image: self.$header, isPresented: self.$selectImage)
            }
            
            
            
            Button(action: {
               
                if self.username == ""{
                    self.showtips.toggle()
                }else{
                    
                self.mycenterdata.ToMain.toggle()
                RealmDB().insertMyInfo(header: ImageTranser().ImageToData(image: self.header ??  UIImage(named:"MyImageBack")!),
                                       background: ImageTranser().ImageToData(image: UIImage.init(named: "background")!),
                                       name: self.username)
                }
            }) {
                Text("进入主页")
                    .foregroundColor(.white)
                
            }.frame(width: 120, height: 45, alignment: .center)
                .background(Color.init("MainThemeColor"))
                .cornerRadius(15)
                .padding(.bottom,60)
            
            .alert(isPresented: $showtips) {
                Alert(title: Text("提示"),
                      message: Text( "请设置一个用户名哦"),
                      dismissButton: .default(Text("我知道了")))
            }
            
        }
    }
}

struct SetInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SetInfoView(mycenterdata: MyInfoData())
    }
}


