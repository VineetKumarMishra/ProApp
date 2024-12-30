//
//  LoginViewModel.swift
//  ProApp
//
//  Created by Vineet Mishra on 10/12/24.
//

import Foundation

import Foundation

protocol AuthenticationServiceProtocol {
    func login(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}


// ViewModel
class LoginViewModel: ObservableObject {
    @Published var email = "user@example.com"
    @Published var password = "password123"
    @Published var isLoading = false
    @Published var loginError: String?
    @Published var isLoginSuccessful: Bool = false
    @Published var showAlert: Bool = false

    private let authService: AuthenticationServiceProtocol

    // Dependency injection for easier testing
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }

    // Validation Logic
    func validateEmail() -> String? {
        if email.isEmpty {
            return "Email is required."
        }
        let emailPattern = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let result = email.range(of: emailPattern, options: .regularExpression)
        return result == nil ? "Invalid email format." : nil
    }

    func validatePassword() -> String? {
        if password.isEmpty {
            return "Password is required."
        }
        if password.count < 6 {
            return "Password must be at least 6 characters long."
        }
        return nil
    }

    var isFormValid: Bool {
        return validateEmail() == nil && validatePassword() == nil
    }

    // Login Method
    func login() {
        guard isFormValid else {
            loginError = "Invalid email or password."
            showAlert = true
            return
        }

        isLoading = true
        loginError = nil

        authService.login(username: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.isLoginSuccessful = true
                case .failure(let error):
                    self?.loginError = error.localizedDescription
                }
            }
        }
    }
}
