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
    var body: some View {
        VStack{
            HStack{
                Text("头像")
                Image(uiImage: header ?? UIImage(named: "AppIcon")!)
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                .cornerRadius(90)
                .scaledToFit()
                .clipped()
                    .onTapGesture {
                        self.selectImage.toggle()
                }
                
            }
            HStack{
                Text("用户名")
                TextField("输入你的用户名", text: $username)
            }
            
            
            
            }.frame(width: width - 20, height: height)
        .sheet(isPresented:  $selectImage) {
            ImagePicker(image: self.$header, isPresented: self.$selectImage)
        }
        
    }
}

struct SetInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SetInfoView()
    }
}
