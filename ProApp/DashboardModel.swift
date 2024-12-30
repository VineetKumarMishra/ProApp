//
//  DashboardModel.swift
//  ProApp
//
//  Created by Vineet Mishra on 22/12/24.
//



import Foundation



// MARK: - WelcomeElement
struct DashboardModel: Codable,Identifiable{
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
