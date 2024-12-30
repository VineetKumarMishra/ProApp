//
//  DashboardViewModel.swift
//  ProApp
//
//  Created by Vineet Mishra on 22/12/24.
//
//"https:jsonplaceholder.typicode.com/photos"
import Foundation
import Combine

class DashboardViewModel:ObservableObject{
    
    @Published var responseData:[DashboardModel] = []
    var networkManager:NetworkManager?
    var cancellable = Set<AnyCancellable>()
    
    init( networkManager: NetworkManager? = nil) {
        self.networkManager = networkManager
    }
    
    func fatchDashboradData(){
        
        networkManager?.requestAPI(url: "https:jsonplaceholder.typicode.com/photos", httpBody: nil, httpMethod: .get, responseType: [DashboardModel].self)
            .sink(receiveCompletion: { result in
                switch result{
               
                case .finished:
                    print("Success")
                case .failure(_):
                    print("failure")
                }
            }, receiveValue: { [weak self] data in
                print(data)
                self?.responseData = data
            })
            .store(in: &cancellable)
    }
    
}
