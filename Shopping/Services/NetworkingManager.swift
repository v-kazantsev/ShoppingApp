//
//  NetworkingManager.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse: return "Bad response from URL"
            case .unknown: return "Unknown error"
            }
        }
    }
    
    static func fetch(from url: URL) -> AnyPublisher<Data, Error> {
       return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw NetworkingError.badURLResponse
              }
        return output.data
    }
    
    static func handleCompletetion(completion: Subscribers.Completion<Error>) {
        switch completion {
            case .finished: break
//            case .failure(let error): print(error.localizedDescription)
            case .failure(let error): print(error)
        }
    }
}

