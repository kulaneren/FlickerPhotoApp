//
//  PhotoDetailViewController.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import UIKit

final class PhotoDetailViewController: UIViewController {
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelTitleValue: UILabel!
    
    @IBOutlet private weak var labelTakeDate: UILabel!
    @IBOutlet private weak var labelTakeDateValue: UILabel!
    
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var textViewDescription: UITextView!
    
    var viewModel: PhotoDetailViewModelProtocol!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        handleViewModel()
    }
    
    // MARK: Helpers
    
    private func handleViewModel() {
        viewModel.delegate = self
        viewModel.load()
    }
    
    private func updateUI() {
        labelTitle.text = "Title"
        labelTitle.textColor = UIColor.theme.accent
        labelTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        labelTitleValue.text = ""
        labelTitleValue.textColor = UIColor.theme.text
        labelTitleValue.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        labelTakeDate.text = "Date"
        labelTakeDate.textColor = UIColor.theme.accent
        labelTakeDate.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        labelTakeDateValue.text = ""
        labelTakeDateValue.textColor = UIColor.theme.text
        labelTakeDateValue.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        labelDescription.text = "Decription"
        labelDescription.textColor = UIColor.theme.accent
        labelDescription.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textViewDescription.text = ""
        textViewDescription.textColor = UIColor.theme.text
        textViewDescription.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
    }
}

// MARK: - PhotoDetailViewModelDelegate

extension PhotoDetailViewController: PhotoDetailViewModelDelegate {
    func showDetail(_ presentation: PhotoDetailPresentation) {
        if let imageURL = URL(string: presentation.imageURL) {
            image.kf.setImage(with: imageURL)
        }
        labelTitleValue.text = presentation.title
        labelTakeDateValue.text = presentation.date
        textViewDescription.text = presentation.description
    }
}
