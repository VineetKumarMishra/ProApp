//
//  DashboardView.swift
//  ProApp
//
//  Created by Vineet Mishra on 04/12/24.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject var viewModel = DashboardViewModel(networkManager: NetworkManager())
    
    let itemsBySection = [
        "Movies": Array(1...5),
        "Webseries": Array(6...10)
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack{
            Color.orange.opacity(0.4)
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                   
                    ForEach(viewModel.responseData) { item in
                                CardView(item: item)
                                    .frame(height: 240)
                                    .padding(.bottom, 10)
                            }
                     
                }
                .padding()
            }
            .navigationTitle("Bollywood")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                viewModel.fatchDashboradData()
            }
        }
    }
    
    // Extract header as a separate method
    @ViewBuilder
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(8)
            .padding(.bottom,10)
        }
}

#Preview {
    NavigationStack {
        DashboardView(viewModel: DashboardViewModel(networkManager: NetworkManager()))
    }
}

struct CardView: View {
    let item: DashboardModel?
    
    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: .infinity)
                .overlay {
                    VStack {
                        Spacer() // Push content to the bottom
                        Text("Item \(String(describing: item?.title ?? ""))")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.4)) // Black transparent background
                }
            }
                
        }
        .background(Color.blue)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
