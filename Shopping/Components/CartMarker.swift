//
//  CartMarker.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

struct CartMarker: View {
    var body: some View {
        Circle()
            .stroke()
            .foregroundColor(.white)
            .frame(width: 14, height: 14)
            .overlay(
                MediumText(text: "2", size: 10)
                    .foregroundColor(.white)
            )
            .offset(x: 12, y: -4)
    }
}

struct CartMarker_Previews: PreviewProvider {
    static var previews: some View {
        CartMarker()
            .padding()
            .background(Color(.black))
            .previewLayout(.sizeThatFits)
    }
}
