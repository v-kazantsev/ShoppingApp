//
//  HomeModel.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation

struct HomeModel: Decodable {
    let home_store: [HomeStoreModel]
    let best_seller: [BestSellerModel]
}
