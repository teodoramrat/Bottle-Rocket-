//
//  Network.swift
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 12/9/21.
//

import Foundation

enum ResponseError: Error {
    case networkError
    case error(Error)
}

struct NetworkManager {
    static func load(with url: String, completionHandler: @escaping (Result<Data, ResponseError>) -> Void) {
        guard let url = URL(string: url) else {
            print("Wrong URL!")
            return
        }
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        session.dataTask(with: url) { data, response, error in
            guard response != nil else {
                completionHandler(.failure(.networkError))
                return
            }
            if let error = error {
                completionHandler(.failure(.error(error)))
                return
            }
            guard let data = data else { return }
            completionHandler(.success(data))
        }.resume()
    }
}
