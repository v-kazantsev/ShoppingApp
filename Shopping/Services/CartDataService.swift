//
//  CartDataService.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation
import Combine

class CartDataService {
    @Published var cart: CartModel? = nil
    var cartSubscription: AnyCancellable?
    
    init() {
        getCart()
    }
    
    private func getCart() {
        let url = URL(string: "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149")!
        
        cartSubscription = NetworkingManager.fetch(from: url)
            .decode(type: CartModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletetion, receiveValue: { [weak self] (responseData) in
                self?.cart = responseData
                self?.cartSubscription?.cancel()
            })

    }
}

