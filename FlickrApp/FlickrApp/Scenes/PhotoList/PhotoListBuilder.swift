//
//  PhotoListBuilder.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import UIKit
import FlickrAPI

final class PhotoListBuilder {
    
    static func make(apiService: FLPServiceProtocol? = nil) -> PhotoListViewController {
        let storyboard = UIStoryboard(name: "PhotoList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: PhotoListViewController.storyboardIdentifier) as! PhotoListViewController
        
        viewController.viewModel = PhotoListViewModel(apiService: apiService ?? appContainer.apiService)
        
        return viewController
    }
}
