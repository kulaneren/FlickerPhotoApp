//
//  SearchContracts.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import Foundation

protocol SearchViewModelProtocol {
    var delegate: SearchViewModelDelegate? { get set }
    var handleInputsDelegate: SearchViewModelHandleInputsDelegate? { get set }
    func search(text: String, searchType: SearchViewModelSearchType)
}

enum SearchViewModelSearchType {
    case tag
    case name
    case id
}

protocol SearchViewModelHandleInputsDelegate: AnyObject {
    func handleInput(text: String, searchType: SearchViewModelSearchType)
}

enum SearchViewModelOutput {
    case dismissScreen
    case setLoading(Bool)
    case showMessage(String)
}
protocol SearchViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: SearchViewModelOutput)
}
