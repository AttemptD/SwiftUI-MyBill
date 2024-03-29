//
//  ContentView.swift
//  PageView
//
//  Created by Attempt D on 2020/6/22.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI


struct MainView: View {
    @State var selection = 1
    @State var scrollViewContentOffset : CGFloat = 0
    @State var newAddBill = false
    @State var billdata = Model()
    @ObservedObject var appData = AppData()
    @ObservedObject var folderData = FolderData()
    @ObservedObject var mycenterdata : MyInfoData
    @Environment(\.colorScheme) var colorScheme
    @State var window: UIWindow
    let Title = ["钱记","收入","支出"]
    @State var needData = "0"
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            NavigationView{
              
                if #available(iOS 14.0, *) {
                    TabView(selection: $selection) {
                        
                        
                        Home(appData:self.appData,folderData:self.folderData,mycenterdata:self.mycenterdata).tabItem
                        {
                            Image(systemName: "house.fill")
                                .renderingMode(.template)
                            Text("主页")
                            
                        }.tag(1)
                        
                        
                        AllView(folderData:self.folderData,appData:self.appData).tabItem
                        {
                            Image(systemName: "tray.full.fill")
                                .renderingMode(.template)
                            Text("账单")
                        }.tag(2)
                        
                        
                        MyCenterView(appData: self.appData,mycenterdata:self.mycenterdata,window: self.window).tabItem
                        {
                            Image(systemName: "person.crop.circle.fill")
                                .renderingMode(.template)
                            
                            Text("我的")
                            
                        }.tag(3)
                        
                        
                    }
                    .accentColor(Color.init("MainThemeColor"))
                    .sheet(isPresented: self.$newAddBill) {
                        NewAddBillView(appData:self.appData,folderData:self.folderData, billData: self.$billdata, OpenType: "新建",editMoney:self.$needData)
                    }
                    .onChange(of: selection, perform: { value in
                        switch value{
                        case 1:
                            
                            let controller = UIApplication.shared.windows[0].rootViewController as? MyHontingController
                            controller?.statusBarStyle = .lightContent
                            
                        case 2:
                            let controller = UIApplication.shared.windows[0].rootViewController as? MyHontingController
                            controller?.statusBarStyle =  colorScheme != .dark ?  .darkContent : .lightContent
                            
                        case 3:
                            let controller = UIApplication.shared.windows[0].rootViewController as? MyHontingController
                            controller?.statusBarStyle = .lightContent
                            
                        default:
                            break
                        }
                    })
                } else {
                    // Fallback on earlier versions
                    
                    TabView(selection: $selection) {
                        
                        
                        Home(appData:self.appData,folderData:self.folderData,mycenterdata:self.mycenterdata).tabItem
                        {
                            Image(systemName: "house.fill")
                                .renderingMode(.template)
                            Text("主页")
                            
                        }.tag(1)
                        
                        
                        AllView(folderData:self.folderData,appData:self.appData).tabItem
                        {
                            Image(systemName: "tray.full.fill")
                                .renderingMode(.template)
                            Text("账单")
                        }.tag(2)
                        
                        
                        MyCenterView(appData: self.appData,mycenterdata:self.mycenterdata,window: self.window).tabItem
                        {
                            Image(systemName: "person.crop.circle.fill")
                                .renderingMode(.template)
                            
                            Text("我的")
                            
                        }.tag(3)
                        
                        
                    }
                    .accentColor(Color.init("MainThemeColor"))
                    .sheet(isPresented: self.$newAddBill) {
                        NewAddBillView(appData:self.appData,folderData:self.folderData, billData: self.$billdata, OpenType: "新建",editMoney:self.$needData)
                    }
                }
               
            }.navigationViewStyle(StackNavigationViewStyle())
            
            
            if selection != 3{
                Button(action: {
                    self.newAddBill.toggle()
                }) {
                    Image(systemName: "pencil.and.outline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment: .center)
                        .shadow(radius: 5)
                        
                        .foregroundColor(Color.init("MainThemeColor"))
                        .padding(.trailing,20)
                    
                }
                .offset(y:-60)
                
            }
        }
        .onAppear(){
            self.mycenterdata.getMyInfo()
        }
        
        
    }
}





extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

class AnyGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        //To prevent keyboard hide and show when switching from one textfield to another
        if let textField = touches.first?.view, textField is UITextField {
            state = .failed
        } else {
            state = .began
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .ended
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }
}


//始终拥有滑动返回
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

