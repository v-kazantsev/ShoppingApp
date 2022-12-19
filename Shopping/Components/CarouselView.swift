//
//  CarouselView.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

struct CarouselView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(1..<6) { i in
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .overlay(
                                Image("samsung-note")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 212, height: 268)
                                    .clipped()
                            )
                        .scaleEffect(.init(width: scale, height: scale))
                        .padding(.vertical)
                    }
                    .frame(width: 212, height: 320)
                    .padding(16)
                }
                Spacer()
                    .frame(width: 16)
            }
        }
    }
    func getScale(proxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 122
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        var scale: CGFloat = 1.0
        let deltaXAnimationTreshhold: CGFloat = 122
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationTreshhold / 2)
        if diffFromCenter < deltaXAnimationTreshhold {
            scale = 1 + (deltaXAnimationTreshhold - diffFromCenter) / 488
        }
        return scale
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
