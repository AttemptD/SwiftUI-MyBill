//
//  ChartTagle.swift
//  MyBill
//
//  Created by Attempt D on 2021/7/20.
//  Copyright © 2021 Frank D. All rights reserved.
//

import SwiftUI

struct ChartTagle: View {
    
    @State var appData : [week]
    @State var time : [String]
    @State var hover = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            
            HStack(alignment: .bottom){
                
                ForEach(appData){ item in
                    Rectangle()
                        .frame(width: 12, height:CGFloat(item.money), alignment: .center)
                        .cornerRadius(180)
                        .foregroundColor(item.isSelect ? Color.init("MainThemeColor") : Color.init("MainThemeColor"))
                    
                }.frame(width: (width-20)/8.3, alignment: .center)
                
            }.frame(width: width - 20,alignment: .center)
            
            HStack{
                ForEach(time,id: \.self){
                    
                    Text("\($0)")
                        .font(.system(size: 13))
                        .foregroundColor(Color.init("FontColor"))
                        .frame(width: (width-20)/8.3, alignment: .center)
                    
                }
            }
            .frame(width: width - 20,alignment: .center)
            .padding(.bottom,10)
        }
        .frame(width: width - 20, height: height/5, alignment: .bottom)
        .background(self.colorScheme == .dark ? Color.init("MainCellSpacerColor_dark")  :Color.white)
        .cornerRadius(15)
    }
}


