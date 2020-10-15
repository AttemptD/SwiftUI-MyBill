//
//  DetailView.swift
//  pageView
//
//  Created by Attempt D on 2020/7/24.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let billData : Model
    var body: some View {
        Text(billData.doWhat)
        //haptic(type:.error)
        
            
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(billData: Model())
    }
}
