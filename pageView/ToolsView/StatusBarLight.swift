//
//  statusbarlight.swift
//  yixiang-ios
//
//  Created by Attempt D on 2020/4/12.
//  Copyright © 2020 Ai. All rights reserved.
//

import SwiftUI

class MyHontingController: UIHostingController<AnyView> {
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    @objc override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}
