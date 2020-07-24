//
//  DropDownView.swift
//  pageView
//
//  Created by Attempt D on 2020/6/30.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct DropDownView: View {
    
    
    @State var expand = false
    @State var menu = ["支出","收入"]
    @State var show = "支出"
    var body: some View {
        VStack() {
            
            VStack(spacing: 10) {
                HStack() {
                    Text("\(show)")
                       
                        .foregroundColor(.white)
                    
                    
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 13, height: 6)
                        .foregroundColor(.white)
                }
                   
                .contentShape(Rectangle())
                    
                .onTapGesture {
                    self.expand.toggle()
                }
                if expand {
                    
                    Button(action: {
                        self.expand.toggle()
                        self.show = self.menu[0]
                    }) {
                        Text("\(menu[0])")
                            .padding(5)
                       .shadow(color: .black, radius: 3.5, x: 1, y: 1)
                    }.foregroundColor(.white)
                    
                    Button(action: {
                        self.expand.toggle()
                        self.show = self.menu[1]
                    }) {
                        Text("\(menu[1])")
                            .padding(5)
                        .shadow(color: .black, radius: 3.5, x: 1, y: 1)
                    }.foregroundColor(.white)
                    
                    
                }
            }
            .padding(.horizontal)
            .cornerRadius(15)
            .animation(.spring())
        }
    }
    
    
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView()
    }
}
