//
//  GFTitleLabel.swift
//  GitFollowers
//
//  Created by Daylon van wel on 06/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class GFTitleLabel: UILabel {

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	init(textAligment: NSTextAlignment, fontSize: CGFloat) {
		super.init(frame: .zero)

		self.textAlignment = textAligment
		self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)

		self.configure()
	}

	private func configure() {
		textColor = .label
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.90
		lineBreakMode = .byTruncatingTail
		translatesAutoresizingMaskIntoConstraints = false
	}
}
