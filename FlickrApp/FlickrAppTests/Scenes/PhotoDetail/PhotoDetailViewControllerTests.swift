//
//  PhotoDetailViewControllerTests.swift
//  FlickrAppTests
//
//  Created by eren  on 31/10/2023.
//

import XCTest
@testable import FlickrApp
@testable import FlickrAPI

final class PhotoDetailViewControllerTests: XCTestCase {

    var sut: PhotoDetailViewController!

    override func setUpWithError() throws {

        let viewModel = PhotoDetailViewModel(photoItem: FLPPhotoItem(
            title: "test",
            link: "https://www.flickr.com/photos/stevepj2009/53300116688/",
            media: Media(m: "https://live.staticflickr.com/65535/53300116688_5ed78b6208_m.jpg"),
            dateTaken: "2023-10-29T14:58:12-08:00",
            description: "test",
            published: "test",
            author: "test author",
            authorId: "1",
            tags: "test1 test2")
        )

        sut = PhotoDetailBuilder.make(with: viewModel)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testInit() {
        XCTAssertNotNil(sut.viewModel)
    }

    func testViewDidLoad() {
        _ = sut.view
        XCTAssertNotNil(sut.labelTitleValue)
    }

    func testHandleViewModelOutput_withUpdateTitle() {
        _ = sut.view
        sut.showDetail(PhotoDetailPresentation(imageURL: "test", title: "test", date: "123", description: "test"))
        XCTAssertEqual(sut.labelTitleValue.text, "test")
    }
}
