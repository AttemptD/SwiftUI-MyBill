//
//  SwiftUIView.swift
//  MyBill
//
//  Created by Attempt D on 2020/8/13.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct TranserView: View {
    @ObservedObject var mycenterdata = MyInfoData()
    @State var window: UIWindow
    var body: some View {
        
        VStack{
            if mycenterdata.ToMain {
                MainView(mycenterdata:mycenterdata,window: self.window)
            }else{
                SetInfoView(mycenterdata: mycenterdata, openType: "新建")
            }
        }.transition(.identity)
    }
}

