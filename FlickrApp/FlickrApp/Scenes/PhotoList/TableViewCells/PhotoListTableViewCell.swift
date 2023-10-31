//
//  PhotoListTableViewCell.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import UIKit
import Kingfisher

protocol PhotoListTableViewCellDelegate: AnyObject {
    func userInfoTapped(id: String)
}

final class PhotoListTableViewCell: UITableViewCell {

    static let cellIdentifier = "PhotoListTableViewCell"

    @IBOutlet private weak var viewBackground: UIView!

    @IBOutlet private weak var viewUserInfo: UIView!
    @IBOutlet private weak var imageUser: UIImageView!
    @IBOutlet private weak var labelUserName: UILabel!

    @IBOutlet private weak var imageMain: UIImageView!
    @IBOutlet weak var labelTags: UILabel!

    private var presentation: PhotoListPresentation?

    weak var delegate: PhotoListTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    override func prepareForReuse() {
        imageUser.image = nil
        labelUserName.text = nil
        imageMain.image = nil
        labelTags.text = nil
        presentation = nil
    }

    private func updateUI() {
        viewUserInfo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userInfoTapped)))
        viewBackground.layer.cornerRadius = 8
        viewBackground.layer.borderColor = UIColor.theme.accent?.cgColor
        viewBackground.layer.borderWidth = 1
        labelUserName.textColor = UIColor.theme.text
        labelUserName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        imageUser.layer.cornerRadius = imageUser.frame.height / 2
        imageUser.layer.borderColor = UIColor.theme.accent?.cgColor
        imageUser.layer.borderWidth = 1
        labelTags.textColor = UIColor.theme.text
        labelTags.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }

    func configure(presentation: PhotoListPresentation) {
        self.presentation = presentation
        if let userImageURL = URL(string: presentation.userImageURL) {
            imageUser.kf.setImage(with: userImageURL)
        }

        if let mainImageURL = URL(string: presentation.imageURL) {
            imageMain.kf.setImage(with: mainImageURL)
        }

        labelUserName.text = presentation.userName
        labelTags.text = presentation.tags
    }

    // Intents
    @objc private func userInfoTapped() {
        guard let presentation = self.presentation else {
            return
        }
        delegate?.userInfoTapped(id: presentation.userName)
    }
}

