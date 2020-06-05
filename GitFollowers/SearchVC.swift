//
//  SearchVC.swift
//  GitFollowers
//
//  Created by Daylon van wel on 05/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

	let logoImageView = UIImageView()
	let userNameTextField = GFTextField()
	let callToActionButton = GFButton(backGroundColor: .systemGreen, title: "Get Followers")

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.backgroundColor = .systemBackground
		self.configureLogoImageView()
		self.configureTextField()
		self.configureCallToActionButton()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
	}

	func configureLogoImageView() {
		self.view.addSubview(self.logoImageView)
		self.logoImageView.translatesAutoresizingMaskIntoConstraints = false

		self.logoImageView.image = UIImage(named: "gh-logo")

		NSLayoutConstraint.activate([
			self.logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80),
			self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.logoImageView.heightAnchor.constraint(equalToConstant: 200),
			self.logoImageView.widthAnchor.constraint(equalToConstant: 200)
		])
	}

	func configureTextField() {
		self.view.addSubview(self.userNameTextField)

		NSLayoutConstraint.activate([
			self.userNameTextField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 48),
			self.userNameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
			self.userNameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
			self.userNameTextField.heightAnchor.constraint(equalToConstant: 50)
		])
	}

	func configureCallToActionButton() {
		self.view.addSubview(self.callToActionButton)

		NSLayoutConstraint.activate([
			self.callToActionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
			self.callToActionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
			self.callToActionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
			self.callToActionButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}

}
