//
//  BackButton.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.theme.accent)
            .frame(width: 37, height: 37)
            .overlay(
                Image(systemName: "chevron.left").foregroundColor(.white)
        )
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
            .previewLayout(.sizeThatFits)
    }
}
