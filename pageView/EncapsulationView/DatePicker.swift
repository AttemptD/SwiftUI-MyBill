//
//  DatePicker.swift
//  pageView
//
//  Created by Attempt D on 2020/7/10.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct DatePacker: View {
    @State var title :String
    
    @Binding var date : Date
    @State var datetype : Bool
    @State var isshow = false
    @State var color : Color = .gray
    var body: some View {
        
        VStack{
            HStack{
                Text("\(title)")
                Spacer()
                Text("\(dateChanged(date: date))")
                    
                    .foregroundColor(color)
            }
            
            if self.isshow == true {
                Setting(date: self.$date, type: self.$datetype)
            }
            
        }
        .onTapGesture {
            
            if self.isshow == true{
                
                self.isshow = false
                self.color = .gray
                
            }else{
                withAnimation(.default){
                    self.isshow = true
                    self.color = .orange
                }
                
            }
            
        }
   
    }
}

func dateChanged(date:Date) -> String{
    // 更新提醒时间文本框
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy年MM月dd日"
    let time = date
    let dateText = formatter.string(from: time)
    return dateText
}

struct Setting: UIViewRepresentable {
    @Binding var date: Date
    @Binding var type: Bool
    
    private let datePicker = UIDatePicker()
    
    func makeUIView(context: Context) -> UIDatePicker {
        
        let loc = Locale(identifier: "zh_CN")
        datePicker.locale = loc
        if self.type == true {
            datePicker.datePickerMode = .date
        }else{
            datePicker.datePickerMode = .time
        }
        datePicker.minimumDate = Date.init()
        
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.changed(_:)), for: .valueChanged)
        return datePicker
    }
    
    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        datePicker.date = date
    }
    
    func makeCoordinator() -> Setting.Coordinator {
        Coordinator(date: $date)
    }
    
    class Coordinator: NSObject {
        private let date: Binding<Date>
        
        init(date: Binding<Date>) {
            self.date = date
        }
        
        @objc func changed(_ sender: UIDatePicker) {
            self.date.wrappedValue = sender.date
        }
    }
}

