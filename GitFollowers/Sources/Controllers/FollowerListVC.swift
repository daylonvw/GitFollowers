//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by Daylon van wel on 06/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

	var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true

		NetworkManager.shared.getFollowers(for: userName, page: 1) { (followers, errorMessage) in
			guard let followers = followers else {
				self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: errorMessage!.rawValue, buttonTitle: "Ok")
			 return
			}

			print("Followers.count = \(followers.count)")
			print(followers)
		}
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
}
