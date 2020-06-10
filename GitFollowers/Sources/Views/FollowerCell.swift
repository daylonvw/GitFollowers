//
//  FollowerCel.swift
//  GitFollowers
//
//  Created by Daylon van wel on 10/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
	static let reuseID = "FollowerCell"

	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAligment: .center, fontSize: 16)
	let padding: CGFloat = 8

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.configure()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func set(follower: Follower) {
		self.usernameLabel.text = follower.login
		self.avatarImageView.downloadImage(from: follower.avatarUrl)
	}

	private func configure() {
		self.configureAvatarImageView()
		self.configureUsernameLabel()

	}

	private func configureAvatarImageView() {
		self.addSubview(self.avatarImageView)

		NSLayoutConstraint.activate([
			self.avatarImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: padding),
			self.avatarImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
			self.avatarImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
			self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor)
		])
	}

	private func configureUsernameLabel() {
		self.addSubview(self.usernameLabel)

		NSLayoutConstraint.activate([
			self.usernameLabel.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 12),
			self.usernameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
			self.usernameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
			self.usernameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
}
