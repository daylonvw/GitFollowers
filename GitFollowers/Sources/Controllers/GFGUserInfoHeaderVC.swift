//
//  GFGUserInfoHeaderVC.swift
//  GitFollowers
//
//  Created by Daylon van wel on 22/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class GFGUserInfoHeaderVC: UIViewController {

	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAligment: .left, fontSize: 34)
	let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
	let locationImageView = UIImageView()
	let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
	let bioLabel = GFBodyLabel(textAligment: .left)

	var user: User!

	init(user: User) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		self.addSubviews()
		self.layoutUI()
		self.configureUIElelments()
    }

	func addSubviews() {
		self.view.addSubview(self.avatarImageView)
		self.view.addSubview(self.usernameLabel)
		self.view.addSubview(self.nameLabel)
		self.view.addSubview(self.locationImageView)
		self.view.addSubview(self.locationLabel)
		self.view.addSubview(self.bioLabel)

		self.locationImageView.image = UIImage(systemName: SFSymbols.location)
		self.locationImageView.tintColor = .secondaryLabel
	}

	func configureUIElelments() {
		self.avatarImageView.downloadImage(from: self.user.avatarUrl)
		self.usernameLabel.text = self.user.login
		self.nameLabel.text = self.user.name ?? ""
		self.locationLabel.text = self.user.location ?? "No location"
		self.bioLabel.text = self.user.bio ?? "No bio available"
		self.bioLabel.numberOfLines = 4
	}

	func layoutUI() {
		let padding: CGFloat            = 20
		let textImagePadding: CGFloat   = 12
		locationImageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			avatarImageView.widthAnchor.constraint(equalToConstant: 90),
			avatarImageView.heightAnchor.constraint(equalToConstant: 90),

			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
			usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			usernameLabel.heightAnchor.constraint(equalToConstant: 38),

			nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
			nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			nameLabel.heightAnchor.constraint(equalToConstant: 20),

			locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
			locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
			locationImageView.widthAnchor.constraint(equalToConstant: 20),
			locationImageView.heightAnchor.constraint(equalToConstant: 20),

			locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
			locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
			locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			locationLabel.heightAnchor.constraint(equalToConstant: 20),

			bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
			bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
			bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			bioLabel.heightAnchor.constraint(equalToConstant: 60)
		])
	}
}
