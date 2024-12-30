//
//  LoginView.swift
//  ProApp
//
//  Created by Vineet Mishra on 04/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct LoginView: View {
    @State private var isLoggedIn: Bool = false
    
    @StateObject private var viewModel = LoginViewModel(authService: AuthenticationService())
    
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
                
                
                TextField("Please enter email...", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                TextField("Please enter password..", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                Button {
                    viewModel.login()
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
            .alert("ProApp", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.loginError ?? "")
            }
            .navigationDestination(isPresented: $viewModel.isLoginSuccessful) {
                DashboardView()
            }
        }
    }
}

extension LoginView{
    
    
    
}

#Preview {
    LoginView()
}
