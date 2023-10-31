//
//  FLPService.swift
//  FlickrAPI
//
//  Created by eren  on 31/10/2023.
//

import Foundation

public protocol FLPServiceProtocol {
    func getPhotos(byTags tags: [String]?, byUserId userId: String?, completion: @escaping (Result<GetPhotosResponse, Error>) -> Void)
    func getUserPhotoURL(for id: String) -> String
    func searchUserIdWithName(name: String, completion: @escaping (Result<SearchUserIdWithNameResponse, Error>) -> ())
}

public final class FLPService: FLPServiceProtocol {

    enum APIError: Error {
        case noDataReturned
        case invalidUrl
    }

    private struct Constants {
        static let baseUrl = "https://www.flickr.com/services/feeds/photos_public.gne"
        static let defaultUrlParams = "?format=json&nojsoncallback=1&safe_search=1"
    }

    private var urlSession: URLSession

    public init(withURLSession urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    private func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(APIError.invalidUrl))
            return
        }

        let task = urlSession.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    public func getPhotos(byTags tags: [String]? = nil, byUserId userId: String? = nil, completion: @escaping (Result<GetPhotosResponse, Error>) -> Void) {
        var urlString = Constants.baseUrl + Constants.defaultUrlParams

        if let tags = tags, tags.count > 0 {
            urlString += "&tags=\(tags.joined(separator: ","))"
        }

        if let userId = userId, userId != "" {
            urlString += "&id=\(userId)"
        }

        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidUrl))
            return
        }

        request(url: url, expecting: GetPhotosResponse.self, completion: completion)
    }

    public func getUserPhotoURL(for id: String) -> String {
        return "https://www.flickr.com/buddyicons/\(id).jpg"
    }

    public func searchUserIdWithName(name: String, completion: @escaping (Result<SearchUserIdWithNameResponse, Error>) -> ()) {
        
        guard let userName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(APIError.invalidUrl))
            return
        }

        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.people.findByUsername&api_key=944be902c17879753d410ec61a9d0983&username=\(userName)&format=json&nojsoncallback=1") else {
            completion(.failure(APIError.invalidUrl))
            return
        }

        request(url: url, expecting: SearchUserIdWithNameResponse.self, completion: completion)
    }
}
