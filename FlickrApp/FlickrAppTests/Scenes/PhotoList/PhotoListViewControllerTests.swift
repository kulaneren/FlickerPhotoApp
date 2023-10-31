//
//  PhotoListViewControllerTests.swift
//  FlickrAppTests
//
//  Created by eren  on 31/10/2023.
//

import XCTest
@testable import FlickrApp
@testable import FlickrAPI

final class PhotoListViewControllerTests: XCTestCase {

    var sut: PhotoListViewController!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession.init(configuration: configuration)

        let flpService = FLPService(withURLSession: urlSession)
        loadFakeData()
        sut = PhotoListBuilder.make(apiService: flpService)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    private func loadFakeData() {
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
    }

    func testInit() {
        XCTAssertNotNil(sut.viewModel)
    }

    func testViewDidLoad() {
        _ = sut.view
        XCTAssertNotNil(sut.buttonSearch)
    }

    func testHandleViewModelOutput_withUpdateTitle() {
        _ = sut.view
        sut.handleViewModelOutput(.updateTitle("title"))
        XCTAssertEqual(sut.title, "title")
    }

    func testHandleViewModelOutput_withSetLoading() {
        _ = sut.view
        sut.handleViewModelOutput(.setLoading(true))
        XCTAssertNotNil(sut.view.viewWithTag(100))
    }

    func testHandleViewModelOutput_withSetLoadingFalse() {
        _ = sut.view
        sut.handleViewModelOutput(.setLoading(false))
        XCTAssertNil(sut.view.viewWithTag(100))
    }

    // Lets talk about this encapsulation / or testability

//    func testNavigatePhotoDetail() {
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.makeKeyAndVisible()
//        window.rootViewController = photoListViewController
//        let photoListViewController = photoListViewController.view
//        photoListViewController
//    }
}
