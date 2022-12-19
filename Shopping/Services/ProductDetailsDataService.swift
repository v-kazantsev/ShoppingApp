//
//  ProductDetailsDataService.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation
import Combine

class ProductDetailsDataService {
    @Published var productDetails: ProductDetailsModel? = nil
    var productDetailsSubscription: AnyCancellable?
    
    init() {
        getProductDetails()
    }
    
    private func getProductDetails() {
        let url = URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5")!
        
        productDetailsSubscription = NetworkingManager.fetch(from: url)
            .decode(type: ProductDetailsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletetion, receiveValue: { [unowned self] (responseData) in
                                productDetails = responseData
                                productDetailsSubscription?.cancel()
                            })
    }
}

