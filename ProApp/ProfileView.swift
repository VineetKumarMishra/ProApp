//
//  ProfileView.swift
//  ProApp
//
//  Created by Vineet Mishra on 09/12/24.
//

import SwiftUI


struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Image
                Image("1") // Replace with your image name
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .clipShape(Circle()) // Circular profile image
                    .overlay(Circle().stroke(Color.white, lineWidth: 4)) // Border around the image
                    .shadow(radius: 10)
                    .padding(.top, 100)
                   

                // Name
                Text("John Doe")
                    .font(.title)
                    .fontWeight(.bold)

                // Bio
                Text("Software Developer | Swift Enthusiast | Apple Fanatic")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 40)

                // Contact Information Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Contact Information")
                        .font(.headline)
                        .padding(.horizontal, 40)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Email:")
                                .fontWeight(.bold)
                            Spacer()
                            Text("johndoe@example.com")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 40)

                        HStack {
                            Text("Phone:")
                                .fontWeight(.bold)
                            Spacer()
                            Text("+1234567890")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 40)
                        HStack {
                            Text("Location:")
                                .fontWeight(.bold)
                            Spacer()
                            Text("Noida")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 40)
                    }
                    .padding(.bottom, 20)
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                
                // Action Buttons (e.g., Edit, Logout)
                HStack {
                    Button(action: {
                        // Edit Action
                    }) {
                        Text("Edit Profile")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: {
                        // Logout Action
                    }) {
                        Text("Logout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
                .padding(.top, 80)
            }
        }
        .edgesIgnoringSafeArea(.top) // Allow image to stretch into the safe area
    }
}

#Preview {
    ProfileView()
}
