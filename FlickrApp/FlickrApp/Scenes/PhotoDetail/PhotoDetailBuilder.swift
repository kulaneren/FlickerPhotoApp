//
//  PhotoDetailBuilder.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import UIKit

final class PhotoDetailBuilder {
    static func make(with viewModel: PhotoDetailViewModelProtocol) -> PhotoDetailViewController {
        let storyboard = UIStoryboard(name: "PhotoDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: PhotoDetailViewController.storyboardIdentifier) as! PhotoDetailViewController
        viewController.viewModel = viewModel
        
        return viewController
    }
}
