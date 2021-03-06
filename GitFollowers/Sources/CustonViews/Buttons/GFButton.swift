//
//  GFButton.swift
//  GitFollowers
//
//  Created by Daylon van wel on 05/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class GFButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.configure()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	init(backGroundColor: UIColor, title: String) {
		super.init(frame: .zero)

		self.backgroundColor = backGroundColor
		self.setTitle(title, for: .normal)

		self.configure()
	}

	private func configure() {
		layer.cornerRadius = 10
		setTitleColor(.white, for: .normal)
		titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		translatesAutoresizingMaskIntoConstraints = false
	}

	func set(backgroundColor: UIColor, title: String) {
		self.backgroundColor = backgroundColor
		self.setTitle(title, for: .normal)
	}
}
