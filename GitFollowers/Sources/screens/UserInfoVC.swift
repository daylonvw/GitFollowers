//
//  UserInfoVC.swift
//  GitFollowers
//
//  Created by Daylon van wel on 16/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {

	func didTapGithubProfile(for user: User)
	func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {

	let headerView = UIView()
	let itemViewOne = UIView()
	let itemViewTWo = UIView()
	let dateLabel = GFBodyLabel(textAligment: .center)
	var itemViews: [UIView] = []

	var user: Follower!
	weak var delegate: FollowerListVCDelegate!

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
		self.itemViews = [self.headerView, self.itemViewOne, self.itemViewTWo, self.dateLabel]

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
			self.itemViewTWo.heightAnchor.constraint(equalToConstant: itemHeight),

			self.dateLabel.topAnchor.constraint(equalTo: self.itemViewTWo.bottomAnchor, constant: padding),
			self.dateLabel.heightAnchor.constraint(equalToConstant: 18)
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
						self.configureUIElements(with: user)
				}
				case .failure(let message):
					self.presentGFAlertOnMainThread(title: "Something went wrong", message: message.rawValue, buttonTitle: "Ok")
			}
		}
	}

	func configureUIElements(with user: User) {

		let repoItemVC = GFRepoItemVC(user: user)
		repoItemVC.delegate = self

		let followerItemVC = GFFollowerItemVC(user: user)
		followerItemVC.delegate = self

		self.add(childVC: GFGUserInfoHeaderVC(user: user), to: self.headerView)
		self.add(childVC: repoItemVC, to: self.itemViewOne)
		self.add(childVC: followerItemVC, to: self.itemViewTWo)
		self.dateLabel.text = "On github since \(user.createdAt.convertToDisplayFormat())"
	}

	@objc
	func dismissVC() {
		self.dismiss(animated: true )
	}
}

extension UserInfoVC: UserInfoVCDelegate {
	func didTapGithubProfile(for user: User) {
		guard let url = URL(string: user.htmlUrl) else { return }
		self.presentSafariController(with: url)
	}

	func didTapGetFollowers(for user: User) {

		guard user.followers != 0 else {
			self.presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers", buttonTitle: "Ok")
			return
		}

		dismiss(animated: true) {
			self.delegate.didRequestFollowers(for: user.login)
		}
	}
}
