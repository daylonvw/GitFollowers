//
//  UserInfoVC.swift
//  GitFollowers
//
//  Created by Daylon van wel on 16/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

	let headerView = UIView()

	var user: Follower!

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .systemBackground

		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
		self.navigationItem.leftBarButtonItem = doneButton

		self.layoutUI()

		NetworkManager.shared.getUserInfo(for: self.user.login) { [weak self] result in
			guard let self = self else { return }

			switch result {
				case .success(let user):
					DispatchQueue.main.async {
						self.add(childVC: GFGUserInfoHeaderVC(user: user), to: self.headerView)
					}
				case .failure(let message):
					self.presentGFAlertOnMainThread(title: "Something went wrong", message: message.rawValue, buttonTitle: "Ok")
			}
		}

    }

	func layoutUI() {
		self.view.addSubview(self.headerView)
		self.headerView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			self.headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			self.headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			self.headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			self.headerView.heightAnchor.constraint(equalToConstant: 180)
		])
	}

	func add(childVC: UIViewController, to containerView: UIView) {
		self.addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
	}

	@objc
	func dismissVC() {
		self.dismiss(animated: true )
	}
}
