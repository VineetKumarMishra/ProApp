//
//  AuthenticationService.swift
//  ProApp
//
//  Created by Vineet Mishra on 10/12/24.
//

import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    func login(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Simulate an asynchronous network call
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            // Replace this logic with a real API call
            if username == "user@example.com" && password == "password123" {
                completion(.success(true)) // Login successful
            } else {
                let error = NSError(domain: "AuthService", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
                completion(.failure(error)) // Login failed
            }
        }
    }
}
