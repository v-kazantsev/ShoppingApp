//
//  ProductDetailsModel.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation

class ProductDetailsModel: Identifiable, Decodable {
    let id: Int
    let CPU: String
    let camera: String
    let capacity: [String]
    let color: [String]
    let images: [String]
    let isFavorites: Bool
    let price: Int
    let rating: Double
    let sd: String
    let ssd: String
    let title: String
}

