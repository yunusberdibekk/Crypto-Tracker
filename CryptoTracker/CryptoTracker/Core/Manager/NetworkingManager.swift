//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import Combine
import Foundation

enum NetworkingManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unkown

        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                "[🔥] Bad response from URL. \(url)"
            case .unkown:
                "[⚠️] Unkown error occured."
            }
        }
    }

    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { try handleURLResponse(output: $0, url: url) }
            .retry(3) // Eğer handleUrlResponse kısmında hata olursa burası 3 defaya kadar bu isteği tekrardan atacak.!
            .eraseToAnyPublisher()
    }

    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }

    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
