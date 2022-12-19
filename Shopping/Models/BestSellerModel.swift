//
//  BestSellerModel.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation

struct BestSellerModel: Identifiable, Decodable {
    let id: Int
    let is_favorites: Bool
    let title: String
    let price_without_discount: Int
    let discount_price: Int
    let picture: String
}
