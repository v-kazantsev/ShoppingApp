//
//  CarouselView.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

struct CarouselView: View {
    var body: some View {
        VStack() {
            HStack(spacing: 0) {
                Text("Category")
                Spacer()
            }
            .padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(1..<10) { i in
                        GeometryReader { proxy in
                            let scale = getScale(proxy: proxy)
                            ZStack() {
                                Color(.white)
                                    .cornerRadius(20)
                                Image("samsung-1")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 235, height: 296)
                                    .clipped()
                            }
                            .scaleEffect(.init(width: scale, height: scale))
                            .padding(.vertical)
                        }
                        .frame(width: 235, height: 296)
                        .padding(32)
                    }
                    Spacer()
                        .frame(width: 16)
                }
            }
        }
    }
    func getScale(proxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 235
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        var scale: CGFloat = 1.0
        let deltaXAnimationTreshhold: CGFloat = 235
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationTreshhold / 2)
        if diffFromCenter < deltaXAnimationTreshhold {
            scale = 1 + (deltaXAnimationTreshhold - diffFromCenter) / 470
        }
        return scale
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
