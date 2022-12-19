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
                    CarouselView()
                        .frame(width: UIScreen.main.bounds.width, height: 349)
                        .padding(.bottom, 16)
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
            NavigationLink {
                CartView()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.red)
                    .frame(width: 37, height: 37)
                    .overlay(
                        Image(systemName: "bag")
                            .background(CartMarker())
                            .foregroundColor(.white)
                    )
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

struct DetailsCardView: View {
    @ObservedObject var vm: ProductDetailsViewModel
    var body: some View {
        ZStack {
            Color(.white)
                .shadow(color: Color.theme.shadow, radius: 20, x: 0, y: -5)
            VStack(spacing: 0) {
                DetailsCardTitle()
                DetailsCardMenu()
                HStack(spacing: 0) {
                    if let details = vm.productDetails {
                        AdditionalInfoItem(info: details.CPU, iconName: "icon-1")
                        Spacer()
                        AdditionalInfoItem(info: details.camera, iconName: "icon-2")
                        Spacer()
                        AdditionalInfoItem(info: details.sd, iconName: "icon-3")
                        Spacer()
                        AdditionalInfoItem(info: details.ssd, iconName: "icon-4")
                    }
                    
                }
                .padding(.top, 35)
                AddonsPicker(productDetails: $vm.productDetails)
                NavigationLink {
                    CartView()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.theme.red)
                        .overlay(
                            HStack {
                                BoldText(text: "Add To Cart", size: 20)
                                    .foregroundColor(.white)
                                    .padding(.leading, 45)
                                Spacer()
                                if let price = vm.productDetails?.price {
                                    BoldText(text: "$\(price).00", size: 20)
                                        .foregroundColor(.white)
                                        .padding(.trailing, 38)
                                }
                                
                            })
                .frame(width: 355, height: 54)
                .padding(.top, 27)
                }
            }
            .padding(.horizontal, 30)
        }
    }
    
}

struct DetailsCardView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsCardView(vm: ProductDetailsViewModel())
    }
}

struct DetailsCardMenu: View {
    @State var selectedIndex = 0
    var body: some View {
        HStack(spacing: 0) {
            Button {
                selectedIndex = 0
            } label: {
                MenuItem(menuItem: "Shop", selected: selectedIndex == 0)
                    .offset(x: 16)
            }
            Spacer()
            Button {
                selectedIndex = 1
            } label: {
                MenuItem(menuItem: "Details", selected: selectedIndex == 1)
            }
            Spacer()
            Button {
                selectedIndex = 2
            } label: {
                MenuItem(menuItem: "Features", selected: selectedIndex == 2)
            }

            
        }
        .padding(.top, 32)
        .padding(.trailing, 10)
        .frame(maxWidth: .infinity)
    }
}

struct DetailsCardTitle: View {
    var body: some View {
        HStack(spacing: 0) {
            MediumText(text: "Galaxy Note 20 Ultra", size: 24)
            Spacer()
            Button {
                print("added to favorites")
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.accent)
                    .frame(width: 37, height: 33)
                    .overlay(
                        Image(systemName: "heart")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                    )
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        HStack(spacing: 9) {
               ForEach(1..<6) { index in
                   Image(systemName: "star.fill")
                       .foregroundColor(Color.theme.yellow)
               }
           }
           .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MenuItem: View {
    var menuItem: String
    var selected: Bool
    var body: some View {
        Text(menuItem)
            .font(.custom("Mark Pro", size: 20))
            .kerning(-0.33)
            .fontWeight(selected ? .bold : .regular)
            .foregroundColor(selected ? Color.theme.accent : .black.opacity(0.5))
            .padding(.bottom, 8)
            .overlay(selected
                ? Rectangle()
                    .frame(width: 86, height: 3, alignment: .bottom)
                        .foregroundColor(Color.theme.red)
                 : nil,
                     alignment: .bottom
            )
    }
}

struct AdditionalInfoItem: View {
    var info: String
    var iconName: String
    var body: some View {
        VStack(spacing: 9) {
            Image(iconName)
                .tint(Color.theme.gray)
            RegularText(text: info, size: 11)
                .foregroundColor(Color.theme.gray)
        }
    }
}

struct AddonsPicker: View {
    
    @Binding var productDetails: ProductDetailsModel?
    @State var selectedColor = 0
    @State var selectedCapacity = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BoldText(text: "Select color and capacity")
                .foregroundColor(Color.theme.accent)
            HStack(spacing: 0) {
                if let details = productDetails {
                    ForEach(details.color.indices, id:\.self) { index in
                        Button {
                            selectedColor = index
                        } label: {
                            Circle()
                                .fill(Color(hex: details.color[index]) ?? Color.theme.brown)
                                .frame(width: 40, height: 40)
                                .overlay(selectedColor == index
                                    ? Image(systemName: "checkmark").tint(.white)
                                     : nil
                                )
                        }
                        .padding(.trailing, 19)
                    }
                }
                
                Button {
                    selectedCapacity = 1
                } label: {
                    HeavyText(text: "128 GB", size: 13)
                        .foregroundColor(selectedCapacity == 1 ? .white : Color.theme.secondaryGray)
                        .background(selectedCapacity == 1
                                    ? Capsule()
                                        .fill(Color.theme.red)
                                        .frame(width: 71.5, height: 30.3)
                                    : nil
                        
                        )
                }
                .padding(.trailing, 35)
                .padding(.leading, 58)
                Button {
                    selectedCapacity = 2
                } label: {
                    HeavyText(text: "256 gb", size: 13)
                        .foregroundColor(selectedCapacity == 2 ? .white : Color.theme.secondaryGray)
                        .background(selectedCapacity == 2
                                    ? Capsule()
                                        .fill(Color.theme.red)
                                        .frame(width: 71.5, height: 30.3)
                                    : nil
                        )
                }


            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 15)
        }
        .padding(.top, 29)
    }
}

