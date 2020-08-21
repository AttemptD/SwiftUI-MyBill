//
//  MyNavigationBar.swift
//  pageView
//
//  Created by Attempt D on 2020/7/9.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct MyNavigationBar: View {
    @Binding var scrollViewContentOffset : CGFloat
    @Binding var middle : String
    @State var right : String
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                // iPhone x -> 88pt iPhone x not -> 64pt
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height >= 812 ? 88 : 64)
                    .foregroundColor(Color(red: 0.914, green: 0.619, blue: 0.242, opacity: -scrollViewContentOffset > height/4.5 ? 1 : 0))
                HStack(alignment:.center){
                    
                    Text("")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .bold()
                        .padding(.leading, 15.0)
                        .frame(width: 80, height: UIScreen.main.bounds.height >= 812 ? 88 : 64, alignment: .leading)
                    
                    Spacer()
                    Text(-scrollViewContentOffset > height/4.5 ? self.middle : "")
                        .foregroundColor(.white)
                        .font(.system(size: 17))
                    
                        .bold()
                        .padding(.top,20)
                        .frame(width: 100, height: UIScreen.main.bounds.height >= 812 ? 88 : 64, alignment: .center)
                        .animation(.none)
                    
                    
                    
                    Spacer()
                    Button(action: {
                        
                    }) {
                        if self.right == "透明"{
                         Image(self.right )
                        }else{
                            Image(systemName: self.right)
                                .padding(.top,10)
                        }
                       
                            //.resizable().frame(width: 30,height: 10)
                    }
                        
                    .accentColor(.white)
                    .padding(.trailing, 15.0)
                    .frame(width: 80, height: UIScreen.main.bounds.height >= 812 ? 88 : 64, alignment: .trailing)
                    
                }
                .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height >= 812 ? 88 : 64,alignment: .top)
                .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: -scrollViewContentOffset >  height/4.5 ? 1 : 0))
            }
            Spacer()
        }
        .animation(.spring())
    }
}

