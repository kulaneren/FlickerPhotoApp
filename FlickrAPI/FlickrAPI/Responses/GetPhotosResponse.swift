//
//  GetPhotosResponse.swift
//  FlickrAPI
//
//  Created by eren  on 31/10/2023.
//

import Foundation

public struct GetPhotosResponse: Codable {
    public let title: String
    let link: String
    public let description: String
    let modified: String
    let generator: String
    public let items: [FLPPhotoItem]

    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case link = "link"
        case description = "description"
        case modified = "modified"
        case generator = "generator"
        case items = "items"
    }
}
