//
//  RepositoryProfileViewController.swift
//  RobustaTask
//
//  Created by Assem on 15/10/2022.
//

import UIKit

class RepositoryProfileViewController: UIViewController {

    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var publicGistsLabel: UILabel!
    @IBOutlet weak var publicReposLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: RepositoryProfileViewModel!

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }


    // MARK: Helper Methods
    private func setupView() {
        title = "Repository Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        ownerImageView.contentMode = .scaleAspectFill
        ownerImageView.layer.cornerRadius = 10
        ownerImageView.layer.masksToBounds = true
    }

    private func setupViewModel() {
        viewModel.successHandler.onUpdate = { [weak self] result in
            self?.fillData(model: result)
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
        viewModel.errorHandler.onUpdate = { [weak self] _ in
            guard let error = self?.viewModel.errorHandler.value else {return}
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            self?.showAlertmessage(with: error)
        }
        viewModel.fetchRepoProfileInfo(currentPage: viewModel.currentpage)
    }


    private func fillData(model: RepositoryOwner?) {
        followingLabel.text = "\(model?.following ?? 0)"
        followersLabel.text = "\(model?.followers ?? 0)"
        publicGistsLabel.text = "\(model?.public_gists ?? 0)"
        publicReposLabel.text = "\(model?.public_repos ?? 0)"
        ownerNameLabel.text = model?.name
        guard let url = model?.avatar_url else {
            return
        }
        ownerImageView.loadImageUsingCache(withUrl: url)
        guard let repoCreationDate = model?.created_at else {return}
         let isRepoDateMoreThan6Months = repoCreationDate.isRepoDateMoreThan6Months()
        guard let formattedDate = FormattedDate(dateString: repoCreationDate) else {return}
        dateLabel.text = isRepoDateMoreThan6Months ? formattedDate.dayname + ", " + formattedDate.month + " " + formattedDate.day + ", " + formattedDate.year : "\(repoCreationDate.months) ago"
    }
}

