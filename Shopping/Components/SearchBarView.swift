//
//  SearchBarView.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

struct SearchBarView: View {
    
    @State var searchText = ""
    @Binding var isFiltersShown: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16))
                    .foregroundColor(Color.theme.red)
                    .padding(.leading, 24)
                TextField("Search", text: $searchText)
                    .foregroundColor(searchText.isEmpty ? Color.theme.accent.opacity(0.5) : Color.theme.accent)
                    .padding(.leading, 36)
            }
            .frame(width: 300, height: 34, alignment: .leading)
            .font(.custom("Mark Pro", size: 12))
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(.white)
            )
            Button {
                print("search button tapped")
            } label: {
                Circle()
                    .fill(Color.theme.red)
                    .frame(width: 34, height: 34)
                    .overlay(Image("search-button"))
            }
            .padding(.leading, 11)
            Spacer()
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(isFiltersShown: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
