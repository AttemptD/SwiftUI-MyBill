////
////  HomeView.swift
////  PageView
////
////  Created by Attempt D on 2020/6/22.
////  Copyright © 2020 Frank D. All rights reserved.
////
//
//import SwiftUI
//
//struct RememberView: View {
//    @State var pageType = 0
//    @State var haveTo : CGFloat = -height
//   
//    @State var barTitle = ["钱记","收入","支出"]
//    @ObservedObject var folderData : FolderData
//    var body: some View {
//
//        ZStack(alignment:.top){
//
//
//            PageViewController(controllers:
//                [UIHostingController(rootView: )
//                    ,UIHostingController(rootView: EarningView(appData: self.appData)),
//                     UIHostingController(rootView: PayView(appData: self.appData))], currentPage: $pageType)
//                .padding(.top,60)
//
//
//
//            MyNavigationBar(scrollViewContentOffset: self.$haveTo, middle: self.$barTitle[pageType], right: "透明")
//
//        }.edgesIgnoringSafeArea(.top)
//
//    }
//}
//
//
