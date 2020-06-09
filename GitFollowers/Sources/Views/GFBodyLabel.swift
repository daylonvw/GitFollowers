//
//  GFBodyLabel.swift
//  GitFollowers
//
//  Created by Daylon van wel on 06/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	init(textAligment: NSTextAlignment) {
		super.init(frame: .zero)
		self.textAlignment = textAligment

		self.configure()
	}

	private func configure() {
		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = true
		font = UIFont.preferredFont(forTextStyle: .body)
		minimumScaleFactor = 0.75
		lineBreakMode = .byWordWrapping
		translatesAutoresizingMaskIntoConstraints = false
	}
}
