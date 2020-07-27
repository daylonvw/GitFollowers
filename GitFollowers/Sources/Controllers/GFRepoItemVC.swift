//
//  GFRepoItemVC.swift
//  GitFollowers
//
//  Created by Daylon van wel on 23/07/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {

	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Properties
	// —————————————————————————————————————————————————————————————————————————

	weak var delegate: UserInfoVCDelegate!
			
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
		self.itemInfoViewOne.set(itemInfoType: .repos, withCount: self.user.publicRepos)
		self.itemInfoViewTwo.set(itemInfoType: .gists, withCount: self.user.publicGists)
		self.actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
	}

	override func actionButtonTapped() {
		self.delegate.didTapGithubProfile(for: self.user)
	}
}
