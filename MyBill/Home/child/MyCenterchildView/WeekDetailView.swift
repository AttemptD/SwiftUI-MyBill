//
//  WeekDetailView.swift
//  MyBill
//
//  Created by Attempt D on 2020/9/14.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct WeekDetailView: View {
     @Environment(\.colorScheme) var colorScheme
    var body: some View {
        FancyScrollView(title: "设置",
                        headerHeight: 200,
                        scrollUpHeaderBehavior: .parallax,
                        scrollDownHeaderBehavior: .offset,
                        showTitle: true,
                        header: { Image(colorScheme == .dark ? "Setting_dark" : "Setting").resizable().scaledToFill() })
        {
            Text("")
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
    }
}

struct WeekDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeekDetailView()
    }
}
