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
            
            Text("").frame(width:width,height:height/4)
                .background(Color.orange)
        }
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
