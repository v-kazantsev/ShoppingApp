//
//  CartItemModel.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation

struct CartItemModel: Identifiable, Decodable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}
