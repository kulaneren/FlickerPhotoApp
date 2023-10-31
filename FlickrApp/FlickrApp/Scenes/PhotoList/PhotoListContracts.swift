//
//  PhotoListContracts.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import Foundation

protocol PhotoListViewModelProtocol {
    var delegate: PhotoListViewModelDelegate? { get set }
    func load()
    func selectPhoto(at index: Int)
    func search()
    func getPhotosForUserId(id: String)
}

enum PhotoListViewModelOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showPhotoList([PhotoListPresentation])
    case showMessage(String)
}

enum PhotoListViewRoute {
    case photoDetail(PhotoDetailViewModelProtocol)
    case searchScreen(SearchViewModelProtocol)
}

protocol PhotoListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: PhotoListViewModelOutput)
    func navigate(to route: PhotoListViewRoute)
}
