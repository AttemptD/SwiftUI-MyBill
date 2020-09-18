//
//  StyleTheme.swift
//  MyBill
//
//  Created by Attempt D on 2020/9/4.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct StyleTheme: View {
    @State var changeModel = false
    @State var window: UIWindow
    @Environment(\.presentationMode) var persentationMode
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack(alignment:.topLeading){
            
            
            StyleTheme_animtion()
                .offset(y:-width/2.5)
            
            
            VStack(spacing:20){
                
                HStack{
                    VStack{
                        Image("day").resizable().frame(width: 108, height: 192)
                            .cornerRadius(10)
                        Text("浅色")
                        
                        Button(action: {
                            
                            self.changeModel = false
                            self.window.overrideUserInterfaceStyle = .light
                            
                            let controller = UIApplication.shared.windows[0].rootViewController as? MyHontingController
                            controller?.statusBarStyle = .darkContent
                            
                            userDefault.set("light", forKey: "style")
                            
                        }) {
                            
                            Image(systemName: self.colorScheme == .dark ?  "circle" :"checkmark.circle.fill")
                                .foregroundColor(self.colorScheme == .dark ? .gray : .yellow)
                        }.transition(.opacity)
                        
                    }
                    
                    Spacer()
                    
                    VStack{
                        Image("night").resizable().frame(width: 108, height: 192)
                            .cornerRadius(10)
                        Text("深色")
                        Button(action: {
                            
                           
                            self.window.overrideUserInterfaceStyle = .dark
                            
                            
                            let controller = UIApplication.shared.windows[0].rootViewController as? MyHontingController
                            controller?.statusBarStyle = .lightContent
                            
                            userDefault.set("dark", forKey: "style")
                        }) {
                            Image(systemName: self.colorScheme == .dark ? "checkmark.circle.fill" :  "circle")
                                .foregroundColor(self.colorScheme == .dark ? .yellow : .gray)
                        }
                    }
                }.padding(.horizontal,40)
                    
                    .frame(width: width-20)
                    .padding(.vertical,20)
                    .background(self.colorScheme == .dark ? Color.init("MainCellSpacerColor_dark"):Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                
                
                Button(action: {
                    
                    self.window.overrideUserInterfaceStyle = .unspecified
                    
                    if self.colorScheme == .dark {
                       
                        let controller = UIApplication.shared.windows[0].rootViewController as? MyHontingController
                        controller?.statusBarStyle = .lightContent
                        
                    }else{
                        
                       
                        let controller = UIApplication.shared.windows[0].rootViewController as? MyHontingController
                        controller?.statusBarStyle = .darkContent
                    }
                    
                    userDefault.set("system", forKey: "style")
                    
                }) {
                    
                    Text("跟随系统")
                        .foregroundColor(.yellow)
                    
                    
                    
                    
                }
                .frame(width: width-20, height: 40, alignment: .center)
                .background(self.colorScheme == .dark ? Color.init("MainCellSpacerColor_dark"):Color.white)
                .contentShape(Rectangle())
                .cornerRadius(10)
                .shadow(radius: 5)
                
                
                
               
            }.frame(width: width, alignment: .center)
                .offset(y:width/1.5)
            
            
            Button(action: {
                self.persentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .scaleEffect(1.2)
                    .foregroundColor(colorScheme == .dark ? .white :.black)
                    .padding(.leading,25)
                    .padding(.top,10)
                
            }.frame(width: 50, height: 30, alignment: .center)
                .contentShape(Rectangle())
            
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        
        
        
    }
}


