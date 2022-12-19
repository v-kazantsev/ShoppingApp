//
//  DetailsView.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

struct DetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var vm = ProductDetailsViewModel()
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    detailsNavBar
                        .padding(.bottom, 30)
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 349)
                        .padding(.bottom, 7)
                    DetailsCardView(vm: vm)
                        .frame(width: UIScreen.main.bounds.width, height: 471)
                        .cornerRadius(30)
                    Spacer()
                }
            }
        }
    }
    
    private var detailsNavBar: some View {
        HStack(spacing: 0) {
            Spacer()
            BackButton()
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.trailing, 51)
            MediumText(text: "Product Details", size: 18)
                .foregroundColor(Color.theme.accent)
                .padding(.trailing, 79)
            Button {
                print("cart tapped")
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.red)
                    .frame(width: 37, height: 37)
                    .overlay(Image(systemName: "bag").foregroundColor(.white))
            }
            Spacer()

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationBarHidden(true)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
