//
//  NetworkManager.swift
//  ProApp
//
//  Created by Vineet Mishra on 22/12/24.
//

import Foundation
import Combine
import Network

class NetworkManager {
    
    func requestAPI<T: Codable>(
        url: String,
        httpBody: T?,
        httpMethod: HTTPMethod,
        responseType: T.Type
    ) -> AnyPublisher<T, Error> {
        
        guard NetworkMonitor.shared.isConnected else {
                  return Fail(error: NetworkError.noInternet).eraseToAnyPublisher()
              }
        
        guard let url = URL(string: url) else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        
        // Set HTTP Method
        request.httpMethod = httpMethod.rawValue
        
        // Set Headers
        request.setValue("application/json", forHTTPHeaderField: HTTPHeader.contentType.rawValue)
        
        // Assuming token can be dynamic
        let token = "your_access_token_here" // Replace with your token logic
        request.setValue("Bearer \(token)", forHTTPHeaderField: HTTPHeader.authorization.rawValue)
        
        // Encode HTTP Body if provided
        if let body = httpBody {
            do {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
            } catch {
                return Fail(error: NetworkError.badRequestBody).eraseToAnyPublisher()
            }
        }
        
        // Make Network Request
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { response in
                guard
                    let httpResponse = response.response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode)
                else {
                    throw NetworkError.badServerResponse
                }
                return response.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: responseType, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is URLError:
                    return NetworkError.badServerResponse
                case is DecodingError:
                    return NetworkError.decodingError
                default:
                    return NetworkError.unknownError
                }
            }
            .eraseToAnyPublisher()
    }
}


// Enum for HTTP methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

// Enum for Header Keys
enum HTTPHeader: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

// Enum for Custom Errors
enum NetworkError: Error {
    case noInternet
    case badURL
    case badRequestBody
    case decodingError
    case badServerResponse
    case unknownError
}



class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    private(set) var isConnected: Bool = false
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
