//
//  SettingModel.swift
//  MyBill
//
//  Created by Attempt D on 2020/9/1.
//  Copyright © 2020 Frank D. All rights reserved.
//

import Foundation
import Combine

struct SettingModel:Identifiable {
    
    var id: Int = 0
    var seleterName = ""
    var seleterIcon = ""
    
}

class SettingData: ObservableObject {
    
    @Published var settingData = [
        SettingModel(id: 0, seleterName: "资料修改", seleterIcon: "资料修改"),
        SettingModel(id: 1, seleterName: "背景修改", seleterIcon: "背景修改"),
        SettingModel(id: 2, seleterName: "主题样式", seleterIcon: "主题样式"),
        SettingModel(id: 3, seleterName: "清理缓存", seleterIcon: "清理缓存"),
        SettingModel(id: 4, seleterName: "反馈", seleterIcon: "反馈"),
        SettingModel(id: 5, seleterName: "关于", seleterIcon: "关于")
    ]
    
}
