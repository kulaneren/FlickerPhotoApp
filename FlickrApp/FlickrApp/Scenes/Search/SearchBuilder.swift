//
//  SearchBuilder.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import UIKit

final class SearchBuilder {
    static func make(with viewModel: SearchViewModelProtocol) -> SearchViewController {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: SearchViewController.storyboardIdentifier) as! SearchViewController
        viewController.viewModel = viewModel

        return viewController
    }
}
