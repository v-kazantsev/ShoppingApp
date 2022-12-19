//
//  HomeStoreModel.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation

struct HomeStoreModel: Identifiable, Decodable {
    let id: Int
    let is_new: Bool?
    let title: String
    let subtitle: String
    let picture: String
    let is_buy: Bool
}
