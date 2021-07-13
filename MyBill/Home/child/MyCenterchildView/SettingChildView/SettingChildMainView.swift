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
    @State var window: UIWindow
    var body: some View {
        
        if(self.settingModel.seleterName == "资料修改"){
            SetInfoView(mycenterdata: self.mycenterdata, openType: "修改")
        }
        
        if(self.settingModel.seleterName == "背景修改"){
            BackgroundEdit(mycenterdata: self.mycenterdata)
        }
        
        if(self.settingModel.seleterName == "主题样式"){
            StyleTheme(window: self.window)
        }
        
        if(self.settingModel.seleterName == "关于"){
            AboutView()
            
            
        }
        
    }
}


