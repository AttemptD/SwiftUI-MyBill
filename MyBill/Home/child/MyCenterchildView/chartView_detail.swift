//
//  chartView_detail.swift
//  MyBill
//
//  Created by Attempt D on 2020/11/27.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct chartView_detail: View {
    
    @State var title = "称生55"
    @State var appData : [Double]
    @Environment(\.presentationMode) var persentationMode
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        VStack(alignment:.center){
            
            HStack{
                
                Button(action: {
                    self.persentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.down")
                        .scaleEffect(1.2)
                        .foregroundColor(colorScheme == .dark ? .white :.black)
                        .padding(.leading,20)
                }
                
                Text("我的")
            }
            .frame(width: width, alignment: .leading)
            .padding(.top,20)
            
            ScrollView{
                
                HStack{
                    Text("详情面板")
                        .font(.title)
                }
                .padding(.leading,20)
                .frame(width: width, alignment: .leading)
                
                
            }
            
        }
        
        
        
    }
}

struct chartView_detail_Previews: PreviewProvider {
    static var previews: some View {
        chartView_detail(appData: [1,2,3,4,5])
            .padding(4.0)
            .previewDevice("iPhone 11pro")
    }
}
