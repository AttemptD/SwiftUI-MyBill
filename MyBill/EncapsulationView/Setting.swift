//
//  Setting.swift
//  MyBill
//
//  Created by Attempt D on 2020/8/13.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        
        ZStack{
            FancyScrollView(title: "设置",
                            headerHeight: 150,
                            scrollUpHeaderBehavior: .parallax,
                            scrollDownHeaderBehavior: .sticky,
                            showTitle: true,
                            header: { EmptyView() }) {
                                VStack{
                                    
                                    Text("测试")
                                }.background(Color.red)
                                
            }.background(Color.init("MainCellSpacerColor"))
            
        } .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
