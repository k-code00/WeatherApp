//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Kojo on 24/10/2023.
//

import Foundation

final class NetworkManager<T: Decodable> {

    // A static function that fetches data from a URL and decodes it into a given type.
    static func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        // Initiating a data task to fetch data from the given URL.
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Check if there's any error with the request.
            guard error == nil else {
                print(String(describing: error!))
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            
            // Ensure the response is of type HTTPURLResponse.
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            // Check if the HTTP status code is 200 (OK).
            guard httpResponse.statusCode == 200 else {
                print("Received HTTP status code: \(httpResponse.statusCode)")
                completion(.failure(.invalidResponse))
                return
            }
            
            // Ensure data is received.
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // Attempt to decode the received data into the specified type.
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch let err {
                print(String(describing: err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
            
        }.resume()
    }
}

// Enum to define possible network errors.
enum NetworkError: Error, Equatable {
    case invalidResponse
    case invalidData
    case error(err: String)
    case decodingError(err: String)
}

extension NetworkError {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidResponse, .invalidResponse),
             (.invalidData, .invalidData):
            return true
        case (.error(let lhsErr), .error(let rhsErr)):
            return lhsErr == rhsErr
        case (.decodingError(let lhsErr), .decodingError(let rhsErr)):
            return lhsErr == rhsErr
        default:
            return false
        }
    }
}

