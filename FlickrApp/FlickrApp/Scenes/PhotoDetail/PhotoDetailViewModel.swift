//
//  PhotoDetailViewModel.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import Foundation
import FlickrAPI
import Utility

final class PhotoDetailViewModel: PhotoDetailViewModelProtocol {

    weak var delegate: PhotoDetailViewModelDelegate?

    private var presentation: PhotoDetailPresentation!

    init(photoItem photo: FLPPhotoItem) {
        self.presentation = PhotoDetailPresentation(
            imageURL: photo.media.m,
            title: photo.title.removingUnderscore,
            date: Date(flpServiceStyle: photo.dateTaken).showAsStandartFormat(),
            description: photo.description.removingHTMLOccurances
        )
    }

    func load() {
        delegate?.showDetail(presentation)
    }
}
