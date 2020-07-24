//
//  HomeAnimation.swift
//  pageView
//
//  Created by Attempt D on 2020/6/30.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct HomeAnimation: View {
    @State var sunMotion  = false
    @State var drawSunPath = false
    @State var rotateLargeFan = false
    @State var rotateSmallFan = false
     var body: some View {
          ZStack {
              Divider() // Vertical and horizontal axis
              Divider()
                  .rotationEffect(.degrees(90))
                  .offset(x: -200)
              Circle() // The left point at which the sun starts
                  .frame(width: 10)
                  .foregroundColor(.yellow)
                  .offset(x: -200 + 25)
              Circle() // The right point at which the sun comes to rest
                  .frame(width: 10)
                  .foregroundColor(.yellow)
                  .offset(x: 175)

              // Circular motion path for the sun
              Circle()
                  .trim(from: 1/2, to: 1)
                  .stroke()
                  .frame(width: 350)
                  .foregroundColor(.black)
                  .offset(x: 0)
                  .opacity(2/10)

              // Draw sun's path as it moves as it moves
              ZStack {

                  Circle()
                      .trim(from: drawSunPath ? 1/2 : 1/2, to: 1)
                      .stroke(Color.yellow, lineWidth: 3)
                      .frame(width: 350)
                      .opacity(drawSunPath ? 0.2 : 0)
                      // Use 2D & 3D rotation to flip where the path is drawn from
                      .rotationEffect(.degrees(180), anchor: .center)
                      .rotation3DEffect(.degrees(180), axis: (x: 90, y: 0, z: 0))
                      .offset(x: 0)
                      .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: false).delay(1))
                      .onAppear() {
                          self.drawSunPath.toggle()
                                      }
                  Image(systemName: "sun.max") // Sun icon
                      .font(.largeTitle)
                      .foregroundColor(.yellow)
                      .offset(x: -175) // Put offset above rotation in order to move it along the circular motion path
                      .rotationEffect(.degrees(sunMotion ? 180: 0))
                      .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: false).delay(1))
                      .onAppear() {
                          self.sunMotion.toggle()
                  }

                  Image(systemName: "moon.circle") // Moon icon
                      .font(.largeTitle)
                      .rotationEffect(.degrees(220))
                      .opacity(1/2)
                      .offset(x: 110, y: -200)

                  Text("Sun & Wind") // Text labels
                      .font(.largeTitle)
                      .multilineTextAlignment(.leading)
                      .offset(x: -110, y: -250)
                      Text("Wind 9,7 km/h SW")
                          .font(.headline)
                      .offset(y: -130)
                  Text("04:40")
                      .offset(x: -176, y: 30)
                  Text("22:12")
                      .offset(x: 176, y: 30)
              }

              // Large fan
              Image("stand_l")
                  .offset(x: -100, y: -40)
                  .opacity(1/2)
              Image("fan_l")
                  .opacity(1/2)
                  .rotationEffect(.degrees(rotateLargeFan ? 360*4 : 0))
                  .offset(x: -100, y: -80)
                  .animation(Animation.easeInOut(duration: 4*4).repeatForever(autoreverses: false))
                  .onAppear() {
                      self.rotateLargeFan.toggle()
                                  }
              // Small fan
              Image("stand_s")
                  .offset(x: -60, y: -20)
                  .opacity(1/2)
              Image("fan_s")
                  .rotationEffect(.degrees(rotateSmallFan ? 360*4 : 0))
                  .offset(x: -60, y: -40)
                  .animation(Animation.easeInOut(duration: 4*4).repeatForever(autoreverses: false))
                  .opacity(1/2)
                  .onAppear() {
                      self.rotateSmallFan.toggle()
                                                  }
          }

      }
}

struct HomeAnimation_Previews: PreviewProvider {
    static var previews: some View {
        HomeAnimation()
    }
}
