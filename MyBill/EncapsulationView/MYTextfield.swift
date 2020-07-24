//
//  MYTextfield.swift
//  pageView
//
//  Created by Attempt D on 2020/7/22.
//  Copyright © 2020 Frank D. All rights reserved.
//

import UIKit
import SwiftUI

struct MyTextField: UIViewRepresentable {
    let keyboardType: UIKeyboardType
    @Binding var text: String
    @State var placeholder : String
    var paddingHor:CGFloat = 10
    func makeUIView(context: Context) -> UITextField {
        
        
        let textField = UITextField(frame: .zero)
        textField.keyboardType = self.keyboardType
        textField.delegate = context.coordinator
        
        textField.text = self.text
        
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = .white
        textField.placeholder = placeholder
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: paddingHor, height: 1));
        textField.leftViewMode = .always
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        DispatchQueue.main.async{
        self.$text.wrappedValue = uiView.text!
       
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self,text: self.$text)
    }
    
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: MyTextField
        var text: Binding<String>
        init(_ textField: MyTextField,text:Binding<String>) {
            self.parent = textField
            self.text = text
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //收起键盘
            textField.resignFirstResponder()
           
            self.text.wrappedValue = textField.text!
            
           
            return true
        }
        
        //结束编辑
        func textFieldDidEndEditing(_ textField: UITextField) {
         
             self.text.wrappedValue = textField.text!
            
        }
        
         //开始编辑
        func textFieldDidBeginEditing(_ textField: UITextField) {
        
           
           
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           

            let pointRange = (textField.text! as NSString).range(of: ".")
            
            if textField.text == "" && string == "." {
                return false
            }
            
            if pointRange.length > 0 && pointRange.location > 0{//判断输入框内是否含有“.”。
                if string == "." {
                    return false
                }
                
               
            }
            
            self.text.wrappedValue = string
            return true
           
        }
    }
}
