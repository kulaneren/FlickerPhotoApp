//
//  SearchViewController.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    @IBOutlet private weak var textFieldSearch: UITextField!
    @IBOutlet private weak var buttonSearch: UIButton!
    
    @IBOutlet private weak var switchSearchByUser: UISwitch!
    @IBOutlet private weak var labelSearchByUser: UILabel!
    
    @IBOutlet private weak var switchSearchByTag: UISwitch!
    @IBOutlet private weak var labelSearchByTag: UILabel!
    @IBOutlet private weak var labelTagsInfo: UILabel!
    
    var viewModel: SearchViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: Helpers
    
    private func updateUI() {
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
        buttonSearch.tintColor = UIColor.theme.accent
        textFieldSearch.textColor = UIColor.theme.text
        
        switchSearchByUser.onTintColor = UIColor.theme.accent
        switchSearchByUser.isOn = true
        labelSearchByUser.text = "Search by username. Example: HWSH"
        labelSearchByUser.textColor = UIColor.theme.text
        labelSearchByUser.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        switchSearchByTag.onTintColor = UIColor.theme.accent
        switchSearchByTag.isOn = false
        labelSearchByTag.text = "Search by tags."
        labelSearchByTag.textColor = UIColor.theme.text
        labelSearchByTag.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        labelTagsInfo.text = "Use space between the tags. For example: Yorkshire nature football"
        labelTagsInfo.textColor = UIColor.theme.text
        labelTagsInfo.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    // MARK: Intents
    
    @IBAction func buttonSearchTapped(_ sender: Any) {
        guard let text = textFieldSearch.text, !text.isEmpty else {
            print("no text")
            return
        }
        view.endEditing(true)
        viewModel.search(text: text,
                         searchType: switchSearchByUser.isOn ? .name : .tag)
    }
    
    @IBAction func switchByUserTapped(_ sender: Any) {
        if switchSearchByUser.isOn {
            switchSearchByTag.isOn = false
        } else {
            switchSearchByTag.isOn = true
        }
    }
    
    @IBAction func switchByTagTapped(_ sender: Any) {
        if switchSearchByTag.isOn {
            switchSearchByUser.isOn = false
        } else {
            switchSearchByUser.isOn = true
        }
    }
}

// MARK: - SearchViewModelDelegate

extension SearchViewController: SearchViewModelDelegate {
    func handleViewModelOutput(_ output: SearchViewModelOutput) {
        switch output {
        case .dismissScreen:
            navigationController?.popViewController(animated: true)
        case .showMessage(let text):
            self.showInfo(message: text)
        case .setLoading(let isLoading):
            isLoading ? showLoading() : hideLoading()
        }
    }
}
