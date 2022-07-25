//
//  Networking.swift
//  SchoolBook
//
//  Created by Davorin Madaric on 22/07/2022.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

extension NetworkError {
    
    init?(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            self = .transportError(error)
            return
        }

        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            self = .serverError(statusCode: response.statusCode)
            return
        }
        
        if data == nil {
            self = .noData
        }
        
        return nil
    }
}

extension URLSession {
  
    func dataTaskHandler(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: request) { data, response, error in
            if let networkError = NetworkError(data: data, response: response, error: error) {
                completion(.failure(networkError))
                return
            }
            
            completion(.success(data!))
        }
    }
}
