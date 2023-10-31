//
//  SearchViewModel.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import Foundation
import FlickrAPI

final class SearchViewModel: SearchViewModelProtocol {

    var delegate: SearchViewModelDelegate?
    weak var handleInputsDelegate: SearchViewModelHandleInputsDelegate?

    private let apiService: FLPServiceProtocol

    init(apiService: FLPServiceProtocol, inputHandlerDelegate: SearchViewModelHandleInputsDelegate) {
        self.apiService = apiService
        self.handleInputsDelegate = inputHandlerDelegate
    }

    func search(text: String, searchType: SearchViewModelSearchType) {
        if searchType == .name {
            getUserIdWithName(apiService: apiService, name: text)
            return
        }

        handleInputsDelegate?.handleInput(text: text, searchType: searchType)
        notify(.dismissScreen)
    }

    // MARK: API Callers

    private func getUserIdWithName(apiService: FLPServiceProtocol, name: String) {
        notify(.setLoading(true))
        apiService.searchUserIdWithName(name: name) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.notify(.setLoading(false))
            }
            switch result {
            case .success(let response):
                if response.stat == "ok", let userId = response.user?.nsid {
                    DispatchQueue.main.async {
                        self.handleInputsDelegate?.handleInput(text: userId, searchType: .id)
                        self.notify(.dismissScreen)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.notify(.showMessage("User not found"))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.notify(.showMessage(error.localizedDescription))
                }
            }
        }
    }

    // MARK: Helpers

    private func notify(_ output: SearchViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
