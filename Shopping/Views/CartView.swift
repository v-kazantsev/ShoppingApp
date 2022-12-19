//
//  CartView.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

struct CartView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject private var vm: CartViewModel

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack(spacing: 0) {
                cartNavBar
                Spacer()
                    .frame(height: 50)
                CartHeader()
                Spacer()
                    .frame(height: 49)
                CartContent(vm: vm)
            }
        }
        .navigationBarHidden(true)
    }
    private var cartNavBar: some View {
        HStack(spacing: 0) {
            Spacer()
            BackButton()
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            MediumText(text: "Add address", size: 15)
                .foregroundColor(Color.theme.accent)
                .padding(.leading, 154)
            LocationButton()
                .padding(.leading, 9)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartViewModel())
    }
}

struct CartHeader: View {
    var body: some View {
        HStack {
            RegularText(text: "My Cart", size: 35)
                .foregroundColor(Color.theme.accent)
                .padding(.leading, 42)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CartContent: View {
    @ObservedObject var vm: CartViewModel
    var body: some View {
        ZStack {
            Color.theme.accent
                .cornerRadius(30)
                .ignoresSafeArea()
            if let cart = vm.cart {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        Spacer()
                            .frame(height: 80)
                        VStack(spacing: 45) {
                            ForEach (cart.basket) {
                                CartItem(
                                    itemName: $0.title,
                                    itemPrice: $0.price,
                                    itemImage: $0.images)
                            }
                        }
                        Spacer()
                            .frame(height: 171)
                        CartTotal(vm: vm)
                        CheckoutButton()
                        Spacer()
                            .frame(height: 44)
                    }
                }
            } else {
                ProgressView()
            }
            
        }
    }
}

struct CartItem: View {
    var itemName: String
    var itemPrice: Int
    var itemImage: String
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            ZStack {
                Color(.white)
                AsyncImage(url: URL(string: itemImage)) {
                    if let image = $0.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 88, height: 88)
                    } else {
                        ProgressView()
                    }
                }
            }
            .frame(width: 88, height: 88)
            .cornerRadius(10)
            VStack(alignment: .leading, spacing: 6) {
                RegularText(text: itemName, size: 20)
                    .foregroundColor(.white)
                    .lineLimit(2)
                RegularText(text: "$\(itemPrice).00", size: 20)
                    .foregroundColor(Color.theme.red)
            }
            .frame(width: 153)
            QuantitySelector()
            Button {
                print("remove tapped")
            } label: {
                Image("trash")
                    .frame(width: 14.75, height: 16)
            }
            .padding(.leading, 17)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct QuantitySelector: View {
    var body: some View {
        VStack(spacing: 0) {
            Button {
                print("minus tapped")
            } label: {
                Image(systemName: "minus")
                    .foregroundColor(.white)
                    .font(.system(size: 10, weight: .black))
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.theme.darkGray)
            MediumText(text: "1", size: 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.theme.darkGray)
                .foregroundColor(.white)
            
            Button {
                print("plus tapped")
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.system(size: 10, weight: .black))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.theme.darkGray)
        }
        .frame(width: 26, height: 68)
        .cornerRadius(26)
    }
}

struct CartTotal: View {
    @ObservedObject var vm: CartViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                RegularText(text: "Total", size: 15)
                    .foregroundColor(.white)
                RegularText(text: "Delivery", size: 15)
                    .foregroundColor(.white)
            }
            .padding(.leading, 55)
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                BoldText(text: "$\(vm.cart!.total) us", size: 15)
                    .foregroundColor(.white)
                BoldText(text: "Free", size: 15)
                    .foregroundColor(.white)
            }
            .padding(.trailing, 35)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 15)
        .overlay(Rectangle().frame(width: nil, height: 2, alignment: .top).foregroundColor(.white.opacity(0.25)), alignment: .top)
        .padding(.bottom, 26)
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(.white.opacity(0.2)), alignment: .bottom)
    }
}

struct CheckoutButton: View {
    var body: some View {
        Button {
            print("checkout tapped")
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.red)
                .overlay(HStack{
                BoldText(text: "Checkout", size: 20)
                        .foregroundColor(.white)
            })
        }
        .frame(width: 326, height: 54)
        .padding(.top, 27)
    }
}

struct LocationButton: View {
    var body: some View {
        Button {
            print("location tapped")
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.red)
                .overlay(
                    Image("marker")
                        .renderingMode(.template)
                        .frame(width: 14, height: 18)
                        .foregroundColor(.white)
                )
        }
        .frame(width: 37, height: 37)
    }
}

