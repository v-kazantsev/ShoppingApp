//
//  HomeDataService.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation
import Combine

class HomeDataService {
    @Published var homeData: HomeModel? = nil
    var homeSubscription: AnyCancellable?
    
    init() {
        getHomeData()
    }
    
    private func getHomeData() {
        let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")!

        homeSubscription = NetworkingManager.fetch(from: url)
            .decode(type: HomeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletetion, receiveValue: { [weak self] (responseData) in
                self?.homeData = responseData
                self?.homeSubscription?.cancel()
            })
    }
}

