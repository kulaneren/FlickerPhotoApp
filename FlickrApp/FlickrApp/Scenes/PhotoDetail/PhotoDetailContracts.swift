//
//  PhotoDetailContracts.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import Foundation

protocol PhotoDetailViewModelProtocol {
    var delegate: PhotoDetailViewModelDelegate? { get set }
    func load()
}

protocol PhotoDetailViewModelDelegate: AnyObject {
    func showDetail(_ presentation: PhotoDetailPresentation)
}
