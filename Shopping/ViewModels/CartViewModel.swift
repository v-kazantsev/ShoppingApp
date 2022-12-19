//
//  CartViewModel.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI
import Combine

class CartViewModel: ObservableObject {
    @Published var cart: CartModel? = nil
    
    private var dataService = CartDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$cart
            .sink { [weak self] (cart) in
                self?.cart = cart
            }
            .store(in: &cancellables)
    }
}
