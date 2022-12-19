//
//  ProductDetailsViewModel.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation
import Combine

class ProductDetailsViewModel: ObservableObject {
    @Published var productDetails: ProductDetailsModel? = nil
    
    private var dataService = ProductDetailsDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$productDetails
            .sink { [weak self] (details) in
                self?.productDetails = details
            }
            .store(in: &cancellables)
    }
}

