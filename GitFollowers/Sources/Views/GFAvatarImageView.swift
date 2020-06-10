//
//  GFAvatarImageView.swift
//  GitFollowers
//
//  Created by Daylon van wel on 10/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

	let placeHolderImage = UIImage(named: "avatar-placeholder")

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.configure()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configure() {
		self.layer.cornerRadius = 10
		self.clipsToBounds = true
		self.image = placeHolderImage
		self.translatesAutoresizingMaskIntoConstraints = false
	}
}
