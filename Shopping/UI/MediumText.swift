//
//  MediumText.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

struct MediumText: View {
    var text: String = ""
    var size: CGFloat = 16
    var body: some View {
        Text(text)
            .font(.custom("Mark Pro Medium", size: size))
            .kerning(-0.33)
    }
}
