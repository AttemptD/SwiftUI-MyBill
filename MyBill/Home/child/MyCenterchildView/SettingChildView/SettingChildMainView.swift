//
//  SettingChildView.swift
//  MyBill
//
//  Created by Attempt D on 2020/9/1.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct SettingChildMainView: View {
    let settingModel:SettingModel
    @ObservedObject var mycenterdata : MyInfoData
    @State var view = AnyView(EmptyView())
    var body: some View {
        
        
        return view.onAppear(){
            switch self.settingModel.seleterName {
            case "资料修改":
                self.view = AnyView(SetInfoView(mycenterdata: self.mycenterdata, openType: "修改"))
            case "背景修改":
                self.view = AnyView(EmptyView())
            case "主题样式":
                self.view = AnyView(EmptyView())
            default:
                self.view = AnyView(EmptyView())
            }
        }
       
    }
}


