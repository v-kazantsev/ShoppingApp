//
//  HomeView.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    @State var isFiltersShown: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            LocationView(isFiltersShown: $isFiltersShown)
                            SectionTitle(title: "Select Category", buttonText: "view all")
                            Spacer()
                                .frame(height: 24)
                            Categories()
                        }
                            SearchBarView(isFiltersShown: $isFiltersShown)
                                .padding(.bottom, 24)
                        VStack(spacing: 0) {
                            SectionTitle(title: "Hot sales", buttonText: "see more")
                            Spacer()
                                .frame(height: 8)
                            HomeStore(homeStoreData: $vm.homeStore)
                            if isFiltersShown {
                                FiltersView(isFiltersShown: $isFiltersShown)
                            }
                        }
                        if !isFiltersShown {
                            VStack(spacing: 0) {
                                SectionTitle(title: "Best Seller", buttonText: "see more")
                                Spacer()
                                    .frame(height: 16)
                                bestSellers
                                Spacer()
                                    .frame(height: 22)
                            }
                        }

                }
                .frame(alignment: .bottom)
                ExplorerView()
            }
            .ignoresSafeArea(edges: [.bottom])
        }
    }
    
    private var bestSellers: some View {
        LazyVGrid(columns: [GridItem(.fixed(187)), GridItem(.fixed(187))]) {
            ForEach(vm.bestSeller) { bestSeller in
                NavigationLink {
                    DetailsView()
                } label: {
                    BestSellerCard(
                        image: bestSeller.picture,
                        sale: "\(bestSeller.discount_price)",
                        price: "\(bestSeller.price_without_discount)",
                        description: bestSeller.title,
                        isFavorite: bestSeller.is_favorites
                    )
                }
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct LocationView: View {
    @Binding var isFiltersShown: Bool
    var body: some View {
        HStack(spacing: 0) {
                Image("marker")
                    .frame(width: 12, height: 15.3)
                    .padding(.trailing, 11)
                    .padding(.leading, 110)
                MediumText(text: "Zihuatanejo, Gro", size: 15)
                    .padding(.trailing, 8)
                Image(systemName: "chevron.down")
                    .tint(Color.theme.gray)
            Image("funnel")
                .frame(width: 11, height: 13)
                .padding(.leading, 76)
                .padding(.trailing, 35)
                .onTapGesture {
                    isFiltersShown = true
                }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 18)
    }
}

struct SectionTitle: View {
    var title: String
    var buttonText: String
    var body: some View {
        HStack(spacing: 0) {
            BoldText(text: title, size: 25)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 17)
            Spacer()
            Button {
                print("view all clicked")
            } label: {
                RegularText(text: buttonText, size: 15)
                    .foregroundColor(Color.theme.red)
            }
            .padding(.trailing, 33)

        }
        .frame(maxWidth: .infinity)
    }
}

struct Categories: View {
    @State var selectedIndex = 0
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 23) {
                Category(selectedIndex: $selectedIndex, image: "iconphones", categoryName: "Phones", isSelected: selectedIndex == 0, index: 0)
                Category(selectedIndex: $selectedIndex, image: "iconcomputers", categoryName: "Computers", isSelected: selectedIndex == 1, index: 1)
                Category(selectedIndex: $selectedIndex, image: "iconheart", categoryName: "Health", isSelected: selectedIndex == 2, index: 2)
                Category(selectedIndex: $selectedIndex, image: "iconbooks", categoryName: "Books", isSelected: selectedIndex == 3, index: 3)
                Category(selectedIndex: $selectedIndex, image: "iconphones", categoryName: "Others", isSelected: selectedIndex == 4, index: 4)
            }
            .padding(.leading, 27)
            .padding(.bottom, 35)
        }
    }
}

struct Category: View {
    @Binding var selectedIndex: Int
    var image: String
    var categoryName: String
    var isSelected: Bool
    var index: Int
    var body: some View {
        VStack(spacing: 7) {
            Button {
                selectedIndex = index
            } label: {
                Circle()
                    .fill(isSelected ? Color.theme.red : Color.white)
                    .overlay(
                    Image(image)
                        .renderingMode(.template)
                        .foregroundColor(isSelected ? Color.white : Color(red: 0.7, green: 0.7, blue: 0.76))
                )
            }
            RegularText(text: categoryName, size: 12)
                .foregroundColor(isSelected ? Color.theme.red : Color.theme.accent)
        }
        .frame(width: 71, height: 93, alignment: .top)

    }
}

struct HomeStore: View {
    
    @Binding var homeStoreData: [HomeStoreModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 18) {
                if homeStoreData.isEmpty {
                    ProgressView()
                        .frame(width: 378, height: 182)
                }
                ForEach(homeStoreData) { homeStore in
                    ZStack(alignment: .trailing) {
                        Color.theme.black
                        DownloadableImageView(imageURL: homeStore.picture)
                            .frame(width: 270, height: 182)
                        VStack(alignment: .leading, spacing: 0) {
                            if let isNew = homeStore.is_new {
                                if isNew {
                                    newMark
                                }
                            }
                            Text(homeStore.title)
                                .font(.system(size: 25))
                                .kerning(-0.33)
                                .bold()
                                .foregroundColor(.white)
                            Text(homeStore.subtitle)
                                .font(.system(size: 11))
                                .kerning(-0.33)
                                .foregroundColor(.white)
                                .padding(.bottom, 25)
                            if homeStore.is_buy {
                                buyNowButton
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 23)
                        .padding(.leading, 22)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 182)
                    .cornerRadius(16)
                }
            }
        }
    }
    private var newMark: some View {
        Circle()
            .fill(Color.theme.red)
            .frame(width: 27, height: 27)
            .overlay(
                Text("New")
                    .font(.system(size: 10))
                    .kerning(-0.33)
                    .bold()
                    .foregroundColor(.white)
            )
            .padding(.bottom, 18)
    }
    private var buyNowButton: some View {
        Button {
            print("buy now tapped")
        } label: {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
                .overlay(
                    Text("Buy now")
                        .font(.system(size: 11))
                        .kerning(-0.33)
                        .bold()
                        .foregroundColor(Color.theme.accent)
                )
                .frame(width: 98, height: 23)
        }
    }
}

struct BestSellerCard: View {
    var image: String
    var sale: String
    var price: String
    var description: String
    var isFavorite: Bool
    var body: some View {
        ZStack(alignment: .top) {
            Color(.white)
                .cornerRadius(10)
                .shadow(color: Color(.black).opacity(0.1), radius: 40, x: 0, y: 0)
            VStack(alignment: .leading, spacing: 0) {
                    DownloadableImageView(imageURL: image)
                    .frame(width: 187, height: 168)
                HStack(alignment: .firstTextBaseline, spacing: 7) {
                    BoldText(text: sale)
                        .foregroundColor(Color.theme.accent)
                    BoldText(text: price, size: 10)
                        .foregroundColor(Color.theme.lightGray)
                }
                .padding(.leading, 21)
                RegularText(text: description, size: 10)
                    .foregroundColor(Color.theme.accent)
                    .padding(.top, 5)
                    .padding(.leading, 21)
            }
            .padding(.top, 5)
            HStack {
                FavoritesButton(isFavorite: isFavorite)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 11)
            .padding(.trailing, 12)
            
        }
        .frame(width: 181, height: 227)
    }
}

struct FavoritesButton: View {
    var isFavorite: Bool
    var body: some View {
        Button {
            print("favorites tapped")
        } label: {
            Circle()
                .fill(.white)
                .overlay(
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 10))
                        .foregroundColor(Color.theme.red)
                )
                .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 0)
                .frame(width: 25, height: 25)
        }

    }
}

struct ExplorerView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.theme.accent)
            .frame(width: UIScreen.main.bounds.width, height: 72)
            .overlay(
                HStack(spacing: 52) {
                    HStack(spacing: 7) {
                        Circle()
                            .fill(.white)
                            .frame(width: 8, height: 8)
                        BoldText(text: "Explorer", size: 15)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, -5)
                    Image(systemName: "bag")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    Image(systemName: "heart")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    Image(systemName: "person")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                }
                    .frame(maxWidth: .infinity, alignment: .center)
            )
    }
}

struct FiltersView: View {
    
    @Binding var isFiltersShown: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                Button {
                    isFiltersShown = false
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.theme.accent)
                        .frame(width: 37, height: 37)
                        .overlay(
                            Image(systemName: "xmark")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        )
                }
                .padding(.trailing, 67)
                MediumText(text: "Filter options", size: 18)
                    .foregroundColor(Color.theme.accent)
                    .padding(.trailing, 44)
                Button {
                    isFiltersShown = false
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.theme.red)
                        .frame(width: 86, height: 37)
                        .overlay(
                            MediumText(text: "Done", size: 18)
                                .foregroundColor(.white)
                        )
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 42)
            .padding(.top, 24)
            FilterView(header: "Brand", filterText: "Samsung")
                .padding(.bottom, 20)
            FilterView(header: "Price", filterText: "$300-$500")
                .padding(.bottom, 20)
            FilterView(header: "Size", filterText: "4.5 to 5.5 inches")
                .padding(.bottom, 44)
        }
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .shadow(color: Color.theme.shadow, radius: 20, y: -5)
        )
        .padding(.top, 10)
    }
}

struct FilterView: View {
    var header: String
    var filterText: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MediumText(text: header, size: 18)
                .foregroundColor(Color.theme.accent)
                .padding(.bottom, 11)
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.theme.lightGray, lineWidth: 1)
                .overlay(
                    HStack(spacing: 0) {
                        RegularText(text: filterText, size: 18)
                            .foregroundColor(Color.theme.accent)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(Color.theme.darkGray)
                    }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 7)
                )
                .frame(width: 337, height: 37)
        }
        .padding(.leading, 37)
    }
}
