//
//  GGCollectionViewFlowLayout.swift
//  GitFollowers
//
//  Created by Daylon van wel on 10/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class GFCollectionViewFlowLayout: UICollectionViewFlowLayout {

	let width: CGFloat!
	let padding: CGFloat = 12
	let minimumItemSpacing: CGFloat = 10
	let totalAvailableWidth: CGFloat!
	let itemWidth: CGFloat!


	init(bounds: CGRect) {
		self.width = bounds.width
		self.totalAvailableWidth = self.width - (self.padding * 2) - (self.minimumItemSpacing * 2)
		self.itemWidth = self.totalAvailableWidth / 3

		super.init()
		
		self.configure(with: bounds)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configure(with bounds: CGRect) {
		self.sectionInset = UIEdgeInsets(top: self.padding, left: self.padding, bottom: self.padding, right: self.padding)
		self.itemSize = CGSize(width: self.itemWidth, height: self.itemWidth + 40)
	}

}
