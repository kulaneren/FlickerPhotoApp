//
//  PhotoListViewController.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import UIKit

final class PhotoListViewController: UIViewController {

    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet private weak var tableView: UITableView!

    private var photoItems: [PhotoListPresentation] = []

    var viewModel: PhotoListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        viewModel.load()
    }

    //MARK: Helpers

    private func updateUI() {
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PhotoListTableViewCell", bundle: nil), forCellReuseIdentifier: PhotoListTableViewCell.cellIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: Intents

    @IBAction func buttonSearchTapped(_ sender: Any) {
        viewModel.search()
    }

}

// MARK: - PhotoListViewModelDelegate

extension PhotoListViewController: PhotoListViewModelDelegate {
    func handleViewModelOutput(_ output: PhotoListViewModelOutput) {
        switch output {
        case .updateTitle(let text):
            self.title = text
        case .showMessage(let text):
            self.showInfo(message: text)
        case .setLoading(let isLoading):
            isLoading ? showLoading() : hideLoading()
        case .showPhotoList(let photoItems):
            self.photoItems = photoItems
            tableView.reloadData()
            if photoItems.count == 0 {
                showInfo(message: "No photo item for this user")
            }
        }
    }

    func navigate(to route: PhotoListViewRoute) {
        switch route {
        case .photoDetail(let viewModel):
            let viewController = PhotoDetailBuilder.make(with: viewModel)
            show(viewController, sender: nil)
        case .searchScreen(let viewModel):
            let viewController = SearchBuilder.make(with: viewModel)
            show(viewController, sender: nil)
        }
    }
}

// MARK: - UITableViewDataSource
extension PhotoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCell.cellIdentifier) as? PhotoListTableViewCell else {
            fatalError()
        }
        let item = photoItems[indexPath.row]
        cell.configure(presentation: item)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PhotoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectPhoto(at: indexPath.row)
    }
}

// MARK: - UITableViewDelegate

extension PhotoListViewController: PhotoListTableViewCellDelegate {
    func userInfoTapped(id: String) {
        viewModel.getPhotosForUserId(id: id)
    }
}
