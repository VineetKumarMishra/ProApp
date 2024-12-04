//
//  LoginView.swift
//  ProApp
//
//  Created by Vineet Mishra on 04/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack{
            Image("loginBackGroundImage")
                .resizable()
                .ignoresSafeArea()
            VStack{
               Spacer()
               Text("Login")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .foregroundStyle(Color.orange)
                
                
                TextField("Please enter email...", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                TextField("Please enter password..", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                Button {
                    handleLogin()
                } label: {
                    
                    Text("Login")
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(20)
                        .padding()
                }
                
                Spacer()

            }
            .alert("ProApp", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                DashboardView()
            }
        }
    }
}

extension LoginView{
    
    func getAlert() -> Alert {
        Alert(title: Text(errorMessage))
        
    }
    func handleLogin() {
            // Simple validation
            if email.isEmpty || password.isEmpty {
                errorMessage = "Email and password are required."
                showAlert = true
                
            } else if !isValidEmail(email) {
                errorMessage = "Please enter a valid email address."
                showAlert = true
            } else {
                errorMessage = ""
                isLoggedIn = true
                // Handle successful login (e.g., API call)
            }
        }
        
        func isValidEmail(_ email: String) -> Bool {
            // Basic email validation regex
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        }
    
}

#Preview {
    LoginView()
}
