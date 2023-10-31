//
//  FLPServiceTests.swift
//  FlickrAPITests
//
//  Created by eren  on 31/10/2023.
//

import XCTest
@testable import FlickrAPI

final class FLPServiceTests: XCTestCase {

    var flpService: FLPService!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession.init(configuration: configuration)

        flpService = FLPService(withURLSession: urlSession)
    }

    override func tearDownWithError() throws {
        flpService = nil
    }

    func testGetPhotos() {
        let jsonString = """
            {
                    "title": "Recent Uploads tagged yorkshire",
                    "link": "https://www.flickr.com/photos/tags/yorkshire/",
                    "description": "",
                    "modified": "2023-10-31T13:29:31Z",
                    "generator": "https://www.flickr.com",
                    "items": [
                   {
                        "title": "",
                        "link": "https://www.flickr.com/photos/stevepj2009/53300116688/",
                        "media": {"m":"https://live.staticflickr.com/65535/53300116688_5ed78b6208_m.jpg"},
                        "date_taken": "2023-10-29T14:58:12-08:00",
                        "description": "",
                        "published": "2023-10-31T13:29:31Z",
                        "author": "nobody@flickr.com",
                        "author_id": "32558319@N03",
                        "tags": "sandalcastle sandal yorkshire wakefield october2023"
                   },
                   {
                        "title": "",
                        "link": "https://www.flickr.com/photos/stevepj2009/53300202703/",
                        "media": {"m":"https://live.staticflickr.com/65535/53300202703_c485fef5a9_m.jpg"},
                        "date_taken": "2023-10-29T15:13:11-08:00",
                        "description": "",
                        "published": "2023-10-31T13:29:11Z",
                        "author": "nobody@flickr.com",
                        "author_id": "32558319@N03",
                        "tags": "sandalcastle sandal yorkshire wakefield october2023"
                   }
                ]
            }
        """

        let data = jsonString.data(using: .utf8)

        URLProtocolMock.requestHandler = { request in
            guard let url = request.url else {
                throw FLPService.APIError.invalidUrl
            }

            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        let photosExpectation = expectation(description: "Expectation")
        flpService.getPhotos() { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.items.count, 2)
                XCTAssertEqual(response.items[0].link, "https://www.flickr.com/photos/stevepj2009/53300116688/")
                XCTAssertEqual(response.items[1].link, "https://www.flickr.com/photos/stevepj2009/53300202703/")
            case .failure(let error):
                XCTAssertNil(error)
            }
            photosExpectation.fulfill()
        }
        wait(for: [photosExpectation], timeout: 3.0)
    }

    func testGetUserPhotoURL() {
        let photoUrl = flpService.getUserPhotoURL(for: "test")

        XCTAssertEqual(photoUrl, "https://www.flickr.com/buddyicons/test.jpg")
    }

    func testSearchUserIdWithName() {
        let jsonString = """
            {"user":{"id":"23319022@N04","nsid":"23319022@N04","username":{"_content":"HWSH"}},"stat":"ok"}
        """

        let data = jsonString.data(using: .utf8)

        URLProtocolMock.requestHandler = { request in
            guard let url = request.url else {
                throw FLPService.APIError.invalidUrl
            }

            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        let userDetailsExpectation = expectation(description: "Expectation")
        flpService.searchUserIdWithName(name: "hwsh", completion: { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.user?.id, "23319022@N04")
                XCTAssertEqual(response.user?.nsid, "23319022@N04")
            case .failure(let error):
                XCTAssertNil(error)
            }
            userDetailsExpectation.fulfill()
        })
        wait(for: [userDetailsExpectation], timeout: 3.0)
    }
}
