//
//  StyleTheme.swift
//  MyBill
//
//  Created by Attempt D on 2020/9/4.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct StyleTheme: View {
    var body: some View {
        VStack{
            
           
            StyleTheme_animtion()
           
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
        
        
    }
}

struct StyleTheme_Previews: PreviewProvider {
    static var previews: some View {
        StyleTheme()
    }
}
