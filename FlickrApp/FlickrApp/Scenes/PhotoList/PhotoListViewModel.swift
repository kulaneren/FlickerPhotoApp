//
//  PhotoListViewModel.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import Foundation
import FlickrAPI

final class PhotoListViewModel: PhotoListViewModelProtocol {

    weak var delegate: PhotoListViewModelDelegate?

    private let apiService: FLPServiceProtocol
    private var photoItems: [FLPPhotoItem] = []

    init(apiService: FLPServiceProtocol) {
        self.apiService = apiService
    }

    func load() {
        getData(tags: ["Yorkshire"])
    }

    private func getData(tags: [String]? = nil,
                         userId: String? = nil) {

        self.notify(.setLoading(true))

        apiService.getPhotos(byTags: tags, byUserId: userId) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.notify(.setLoading(false))
            }
            switch result {
            case .success(let response):
                self.photoItems = response.items
                let presenatations = self.photoItems.map({
                    PhotoListPresentation(userImageURL: self.apiService.getUserPhotoURL(for: $0.authorId), userName: $0.authorId, imageURL: $0.media.m, tags: $0.tags)
                })
                DispatchQueue.main.async {
                    self.notify(.showPhotoList(presenatations))
                    self.notify(.updateTitle( response.title.replacingOccurrences(of: "Recent Uploads tagged ", with: "")))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.notify(.showMessage(error.localizedDescription))
                }
            }
        }
    }

    func selectPhoto(at index: Int) {
        let item = photoItems[index]
        let viewModel = PhotoDetailViewModel(photoItem: item)
        delegate?.navigate(to: .photoDetail(viewModel))
    }

    func search() {
        let viewModel = SearchViewModel(apiService: appContainer.apiService, inputHandlerDelegate: self)
        delegate?.navigate(to: .searchScreen(viewModel))
    }

    func getPhotosForUserId(id: String) {
        getData(userId: id)
    }

    private func notify(_ output: PhotoListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

// MARK: - SearchViewModelHandleInputsDelegate

extension PhotoListViewModel: SearchViewModelHandleInputsDelegate {
    func handleInput(text: String, searchType: SearchViewModelSearchType) {
        var tags: [String]? = nil
        var userId: String? = nil
        switch searchType {
        case .id:
            userId = text
        case .tag:
            tags = text.split(separator: " ").map { String($0) }
        default:
            print("Throw event to notify")
        }

        getData(tags: tags, userId: userId)
    }
}
