//
//  MockAuthenticationService.swift
//  ProAppTests
//
//  Created by Vineet Mishra on 10/12/24.
//

import Foundation

@testable import ProApp

class MockAuthenticationService: AuthenticationServiceProtocol {
    
    var shouldSucceed: Bool = false
    
    func login(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Simulating a network call with a delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            if self.shouldSucceed {
                completion(.success(true)) // Simulate successful login
            } else {
                let error = NSError(domain: "AuthService", code: 401, userInfo: [NSLocalizedDescriptionKey: "Login failed"])
                completion(.failure(error)) // Simulate failed login
            }
        }
    }
}
