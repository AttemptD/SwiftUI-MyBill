import SwiftUI

struct HeaderScrollViewTitle: View {
    let title: String
    let height: CGFloat
    let largeTitle: Double
    @State var showTitle : Bool

    var body: some View {
        let largeTitleOpacity = (max(largeTitle, 0.5) - 0.5) * 2
        let tinyTitleOpacity = 1 - min(largeTitle, 0.5) * 2
        return ZStack {
            
            if showTitle{
                HStack {
                    Text(title)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .fontWeight(.black)
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
                .padding(.bottom, 8)
                .opacity(sqrt(largeTitleOpacity))
            }

            ZStack {
                HStack {
                    BackButton(color: .primary)
                    Spacer()
                }
                HStack {
                    Text(title)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, (height - 18) / 2)
            .opacity(sqrt(tinyTitleOpacity))
        }.frame(height: height)
    }
}
