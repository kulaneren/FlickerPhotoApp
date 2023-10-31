//
//  SearchPhotosResponse.swift
//  FlickrAPI
//
//  Created by eren  on 31/10/2023.
//

import Foundation

public struct SearchUserIdWithNameResponse: Codable {
    public let user: User?
    public let stat: String
    
    private enum CodingKeys: String, CodingKey {
        case user = "user"
        case stat = "stat"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        stat = try values.decode(String.self, forKey: .stat)
    }
}

public struct User: Codable {
    public let id: String
    public let nsid: String
}
