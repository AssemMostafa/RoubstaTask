//
//  RepositoryableViewCell.swift
//  RobustaTask
//
//  Created by Assem on 14/10/2022.
//

import UIKit

class RepositoryableViewCell: UITableViewCell {

    static let identifier = "RepositoryableViewCell"

    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setupView() {
        selectionStyle = .none
        ownerImageView.contentMode = .scaleAspectFill
        ownerImageView.layer.cornerRadius = 10
        ownerImageView.layer.masksToBounds = true
    }
    
    public func configure(with model: Repository) {
        repositoryName.text = model.name
        ownerNameLabel.text = model.owner?.login
        guard let url = model.owner?.avatar_url else {
            return ownerImageView.image = UIImage(named: "mockPoster")

        }
        ownerImageView.loadImageUsingCache(withUrl: url)
    }

}
