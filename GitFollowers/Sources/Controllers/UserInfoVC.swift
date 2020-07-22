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
	let itemViewOne = UIView()
	let itemViewTWo = UIView()
	var itemViews: [UIView] = []

	var user: Follower!

    override func viewDidLoad() {
        super.viewDidLoad()

		self.configureViewcontroller()
		self.layoutUI()
		self.getUserInfo()
    }

	func configureViewcontroller() {
		self.view.backgroundColor = .systemBackground
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
		self.navigationItem.leftBarButtonItem = doneButton
	}

	func layoutUI() {
		self.itemViews = [headerView, itemViewOne, itemViewTWo]

		let padding: CGFloat = 20
		let itemHeight: CGFloat = 140

		for itemView in self.itemViews {
			self.view.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false

			NSLayoutConstraint.activate([
				itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
				itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			])
		}

		NSLayoutConstraint.activate([
			self.headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			self.headerView.heightAnchor.constraint(equalToConstant: 180),

			self.itemViewOne.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: padding),
			self.itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

			self.itemViewTWo.topAnchor.constraint(equalTo: self.itemViewOne.bottomAnchor, constant: padding),
			self.itemViewTWo.heightAnchor.constraint(equalToConstant: itemHeight)
		])
	}

	func add(childVC: UIViewController, to containerView: UIView) {
		self.addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
	}

	func getUserInfo() {
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

	@objc
	func dismissVC() {
		self.dismiss(animated: true )
	}
}
