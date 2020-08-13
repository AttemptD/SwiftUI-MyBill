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
    var body: some View {
        
        VStack{
            if mycenterdata.ToMain {
                MainView(mycenterdata:mycenterdata)
            }else{
                SetInfoView()
            }
        }.transition(.identity)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TranserView()
    }
}
