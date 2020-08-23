//
//  All_ViewAnimation.swift
//  MyBill
//
//  Created by Attempt D on 2020/8/23.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct All_ViewAnimation: View {
    @State private var swinging = false
    @State private var swingLeftLeg = false
    @State private var swingLeftRightLeg = false
    @State private var windBlowsFlowerLeftLeft = false
    @State private var windBlowsFlowerLeftRight = false
    @State private var windBlowsFlowerMiddleLeft = false
    @State private var windBlowsFlowerMiddleRight = false
    @State private var windBlowsFlowerRightLeft = false
    @State private var windBlowsFlowerRightRight = false
    var body: some View {
        ZStack {
            Text("还没有账单哦，请添加一个吧 ！")
                .offset(y: -height/4)
            Image("tree")
                .resizable()
                .scaledToFit()
                .offset(y:40)
            
            
            ZStack {
                Image("leg_left")
                    .resizable()
                    .rotationEffect(.degrees(swingLeftLeg ? 50 : -120), anchor: .top)
                    .scaleEffect(0.032)
                    .offset(x: 110, y: 130)
                    .animation(Animation.easeInOut(duration: 0.4).delay(1).repeatForever(autoreverses: true))
                    .onAppear() {
                        self.swingLeftLeg.toggle()
                }
                Image("leg_right")
                    .resizable()
                    .rotationEffect(.degrees(swingLeftRightLeg ? 25 : -50), anchor: .top)
                    .scaleEffect(0.05)
                    .offset(x: 118, y: 130)
                    .animation(Animation.easeInOut(duration: 0.3).delay(0.4).repeatForever(autoreverses: true))
                    .onAppear() {
                        self.swingLeftRightLeg.toggle()
                }
                
                Image("lady_on_swing")
                    .resizable()
                    .rotationEffect(.degrees(-10))
                    .scaleEffect(0.15)
                    .offset(x: 90, y: 65)
                
            }.rotationEffect(.degrees(swinging ? 15 : -1))
                .animation(Animation.easeOut(duration: 0.4).delay(0.4).repeatForever(autoreverses: true))
                .onAppear() {
                    self.swinging.toggle()
            }
            
            Image("flower_left_right")
                .scaleEffect(0.4)
                .rotationEffect(.degrees(windBlowsFlowerLeftRight ? -5 : 0), anchor: .bottom)
                .offset(x: -35, y: 158)
                .animation(Animation.easeIn(duration: 0.3).repeatForever(autoreverses: true))
                .onAppear() {
                    self.windBlowsFlowerLeftRight.toggle()
            }
            Image("flower_left_left")
                .scaleEffect(0.4)
                .rotationEffect(.degrees(windBlowsFlowerLeftLeft ? 5 : 0), anchor: .bottomTrailing)
                .offset(x: -40, y: 163)
                .animation(Animation.easeOut(duration: 0.25).repeatForever(autoreverses: true))
                .onAppear() {
                    self.windBlowsFlowerLeftLeft.toggle()
            }
            
            Image("flower_middle_right")
                .scaleEffect(0.4)
                .rotationEffect(.degrees(windBlowsFlowerMiddleRight ? 5 : 0), anchor: .bottom)
                .offset(x: 50, y: 160)
                .animation(Animation.easeIn(duration: 0.3).repeatForever(autoreverses: true))
                .onAppear() {
                    self.windBlowsFlowerMiddleRight.toggle()
            }
            Image("flower_middle_left")
                .scaleEffect(0.4)
                .rotationEffect(.degrees(windBlowsFlowerMiddleRight ? -6 : 0), anchor: .bottom)
                .offset(x: 45, y: 157)
                .animation(Animation.easeInOut(duration: 0.25).repeatForever(autoreverses: true))
                .onAppear() {
                    self.windBlowsFlowerMiddleLeft.toggle()
            }
            
            Image("flower_right_right")
                .scaleEffect(0.4)
                .rotationEffect(.degrees(windBlowsFlowerMiddleRight ? -4 : 0), anchor: .bottom)
                .offset(x: 140, y: 160)
                .animation(Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true))
                .onAppear() {
                    self.windBlowsFlowerRightRight.toggle()
            }
            Image("flower_right_left")
                .scaleEffect(0.4)
                .rotationEffect(.degrees(windBlowsFlowerMiddleRight ? 6 : 0), anchor: .bottom)
                .offset(x: 130, y: 158)
                .animation(Animation.easeInOut(duration: 0.25).repeatForever(autoreverses: true))
                .onAppear() {
                    self.windBlowsFlowerRightLeft.toggle()
            }
            
        }
    .frame(width: width-80)
    }
}

struct All_ViewAnimation_Previews: PreviewProvider {
    static var previews: some View {
        All_ViewAnimation()
    }
}
