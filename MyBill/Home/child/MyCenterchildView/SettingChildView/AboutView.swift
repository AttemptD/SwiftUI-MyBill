//
//  AboutView.swift
//  MyBill
//
//  Created by Attempt D on 2020/9/9.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    @State var needdata :CGFloat = -500
    @State var middel = "关于"
    var body: some View {
        ZStack{
        VStack{
            Image("about_icon")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(90)
            Text("记录你的每一笔")
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
       
            
            
            MyNavigationBar(scrollViewContentOffset:$needdata, middle: $middel, right: "透明")
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .navigationBarTitle("关于",displayMode: .inline)
        .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
        
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
