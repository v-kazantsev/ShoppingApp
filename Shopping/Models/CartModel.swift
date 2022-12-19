//
//  CartModel.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation

struct CartModel: Decodable {
    let basket: [CartItemModel]
    let delivery: String
    let id: String
    let total: Int
}
