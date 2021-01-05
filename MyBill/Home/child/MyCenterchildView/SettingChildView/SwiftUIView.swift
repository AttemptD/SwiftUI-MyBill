//
//  SwiftUIView.swift
//  MyBill
//
//  Created by Attempt D on 2020/12/23.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        FancyScrollView(title: "我的",
                        headerHeight: 88,
                        scrollUpHeaderBehavior: .parallax,
                        scrollDownHeaderBehavior:.offset,
                        cornerRadiusNub:0,
                        showTitle:false,
                        header: {
                           EmptyView()
                            
                            
                            
        }){
            
                VStack(spacing:20){
                    Text("dsds")
                  
                    

                }
                .background(Color.init("MainCellSpacerColor"))
                
                
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      
       
        .navigationBarTitle("我的",displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
