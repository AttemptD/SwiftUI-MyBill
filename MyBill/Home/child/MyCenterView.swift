//
//  MyCenterView.swift
//  PageView
//
//  Created by Attempt D on 2020/6/22.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct MyCenterView: View {
    @State var scrollViewContentOffset : CGFloat = 0
    @State private var scale: CGFloat = 1.0
    @State var barTitle = "我的"
    var body: some View {
        ZStack(alignment:.top){
            
            Image("MyImageBack")
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height/3)
                .clipped()
                .blur(radius: scrollViewContentOffset >= 0 ? 2 :  -scrollViewContentOffset/2 + 2,opaque:true)
                .scaleEffect(-scrollViewContentOffset < 0 ? 1 + scrollViewContentOffset / 200 : 1)
                .overlay(Image("MyImageBack")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85, alignment: .center)
                    .clipped()
                    .cornerRadius(50))
                .offset(x: 0, y:-scrollViewContentOffset <= 0 ? 0 : scrollViewContentOffset)
            
            TrackableScrollView(axis: .vertical, showIndicators: false,contentOffset: $scrollViewContentOffset){
                
                
                Spacer().frame(width:width, height: height/3)
                
                HStack{
                    
                    VStack{
                        Text("36")
                            .font(.system(size: 25))
                        Text("全部")
                            .font(.system(size: 15))
                            .fontWeight(.thin)
                        
                    }
                    VStack{
                        Text("").frame(width: 1, height: 50, alignment: .center)
                            .background(Color.init("MainCellSpacerColor"))
                    }
                    .frame(width: width/5, height: 30, alignment: .center)
                    VStack{
                        Text("36")
                            .font(.system(size: 25))
                        Text("支出")
                            .font(.system(size: 15))
                            .fontWeight(.thin)
                    }
                    VStack{
                        Text("").frame(width: 1, height: 50, alignment: .center)
                            .background(Color.init("MainCellSpacerColor"))
                    }
                    .frame(width: width/5, height: 30, alignment: .center)
                    VStack{
                        Text("36")
                            .font(.system(size: 25))
                        Text("收入")
                            .font(.system(size: 15))
                            .fontWeight(.thin)
                    }
                    
                    
                }
                .padding(.horizontal)
                .frame(width: width, height: height/7.5, alignment: .center)
                .background(Color.white)
                
                VStack{
                    Text("")
                }
                
            }
            
            MyNavigationBar(scrollViewContentOffset: self.$scrollViewContentOffset, middle: self.$barTitle, right: "透明")
            
        }
        .background(Color.init("MainCellSpacerColor"))
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle("我的",displayMode: .inline)
        .navigationBarHidden(true)
        
    }
}



struct MyCenterView_Previews: PreviewProvider {
    static var previews: some View {
        MyCenterView()
    }
}
