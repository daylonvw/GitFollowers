//
//  GFSecondaryTitleLabel.swift
//  GitFollowers
//
//  Created by Daylon van wel on 22/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	init(fontSize: CGFloat) {
		super.init(frame: .zero)
		self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)

		self.configure()
	}

	private func configure() {
		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.90
		lineBreakMode = .byTruncatingTail
		translatesAutoresizingMaskIntoConstraints = false
	}
}
