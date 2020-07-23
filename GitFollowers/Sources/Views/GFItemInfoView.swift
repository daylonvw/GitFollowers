//
//  GFItemInfoView.swift
//  GitFollowers
//
//  Created by Daylon van wel on 22/07/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

enum ItemInfoType {
	case repos, gists, followers, following

	var symbolImage: UIImage {
		switch self {
			case .repos:
				return UIImage(systemName: SFSymbols.repos)!
			case .gists:
				return UIImage(systemName: SFSymbols.gists)!
			case .followers:
				return UIImage(systemName: SFSymbols.followers)!
			case .following:
				return UIImage(systemName: SFSymbols.following)!
		}
	}

	var title: String {
		switch self {
			case .repos:
				return "Public Repos"
			case .gists:
				return "Public Gists"
			case .followers:
				return "Followers"
			case .following:
				return "Following"
		}
	}
}

class GFItemInfoView: UIView {

	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Properies
	// —————————————————————————————————————————————————————————————————————————

	let symbolImageView = UIImageView()
	let titleLabel = GFTitleLabel(textAligment: .left, fontSize: 14)
	let countLabel = GFTitleLabel(textAligment: .center, fontSize: 14)

	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Init
	// —————————————————————————————————————————————————————————————————————————

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Private Functions
	// —————————————————————————————————————————————————————————————————————————

	private func configure() {
		self.addSubview(symbolImageView)
		self.addSubview(self.titleLabel)
		self.addSubview(self.countLabel)

		self.symbolImageView.translatesAutoresizingMaskIntoConstraints = false
		self.symbolImageView.contentMode = .scaleAspectFill
		self.symbolImageView.tintColor = .label

		NSLayoutConstraint.activate([
			self.symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
			self.symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.symbolImageView.widthAnchor.constraint(equalToConstant: 20),
			self.symbolImageView.heightAnchor.constraint(equalToConstant: 20),

			self.titleLabel.centerYAnchor.constraint(equalTo: self.symbolImageView.centerYAnchor),
			self.titleLabel.leadingAnchor.constraint(equalTo: self.symbolImageView.trailingAnchor, constant: 12),
			self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			self.titleLabel.heightAnchor.constraint(equalToConstant: 18),

			self.countLabel.topAnchor.constraint(equalTo: self.symbolImageView.bottomAnchor, constant: 4),
			self.countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			self.countLabel.heightAnchor.constraint(equalToConstant: 18)
		])
	}

	public func set(itemInfoType: ItemInfoType, withCount count: Int) {
		self.symbolImageView.image = itemInfoType.symbolImage
		self.titleLabel.text = itemInfoType.title
		self.countLabel.text = String(count)
	}
}
