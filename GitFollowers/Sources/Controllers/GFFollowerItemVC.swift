//
//  GFFollowerItemVC.swift
//  GitFollowers
//
//  Created by Daylon van wel on 23/07/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {

	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Properties
	// —————————————————————————————————————————————————————————————————————————


	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Controller Life Cycle
	// —————————————————————————————————————————————————————————————————————————

	override func viewDidLoad() {
		super.viewDidLoad()

		self.configureItems()
	}

	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Public Functions
	// —————————————————————————————————————————————————————————————————————————

	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Private Functions
	// —————————————————————————————————————————————————————————————————————————

	private func configureItems() {
		self.itemInfoViewOne.set(itemInfoType: .followers, withCount: self.user.followers)
		self.itemInfoViewTwo.set(itemInfoType: .following, withCount: self.user.following)
		self.actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
	}
}
