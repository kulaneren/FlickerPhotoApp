//
//  Item.swift
//  FlickrAPI
//
//  Created by eren  on 31/10/2023.
//

import Foundation

public struct FLPPhotoItem: Codable {
    public let title: String
    public let link: String
    public let media: Media
    public let dateTaken: String
    public let description: String
    public let published: String
    public let author: String
    public let authorId: String
    public let tags: String

    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case link = "link"
        case media = "media"
        case dateTaken = "date_taken"
        case description = "description"
        case published = "published"
        case author = "author"
        case authorId = "author_id"
        case tags = "tags"
    }
}

public struct Media: Codable {
    public let m: String

    private enum CodingKeys: String, CodingKey {
        case m = "m"
    }
}
