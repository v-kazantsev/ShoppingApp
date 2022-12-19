//
//  HomeViewModel.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var homeStore: [HomeStoreModel] = []
    @Published var bestSeller: [BestSellerModel] = []
    @Published var makerFilter: String = ""
    
    private var dataService = HomeDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$homeData
            .sink { [unowned self] (home) in
                guard let homeData = home else { return }
                homeStore = homeData.home_store
                bestSeller = homeData.best_seller
            }
            .store(in: &cancellables)
        
        $makerFilter
            .combineLatest(self.$bestSeller)
            .map { (text, products) -> [BestSellerModel] in
                guard !text.isEmpty else {
                    return products
                }
                let lowercasedText = text.lowercased()
                return products.filter { (product) -> Bool in
                    product.title.lowercased().contains(lowercasedText)
                }
                    
            }
            .sink { [unowned self] (filteredProducts) in
                    bestSeller = filteredProducts
            }
            .store(in: &cancellables)
    }
}
