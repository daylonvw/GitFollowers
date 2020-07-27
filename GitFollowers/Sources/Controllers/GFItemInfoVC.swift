//
//  GFItemInfoVC.swift
//  GitFollowers
//
//  Created by Daylon van wel on 23/07/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController {

	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Properties
	// —————————————————————————————————————————————————————————————————————————

	let stackView = UIStackView()
	let itemInfoViewOne = GFItemInfoView()
	let itemInfoViewTwo = GFItemInfoView()
	let actionButton = GFButton()

	var user: User!

	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Init
	// —————————————————————————————————————————————————————————————————————————

	init(user: User) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Controller Life Cycle
	// —————————————————————————————————————————————————————————————————————————

    override func viewDidLoad() {
        super.viewDidLoad()

		self.configureBackGroundView()
		self.layOutUI()
		self.configureStackView()
		self.configureActionButton()
    }

	// —————————————————————————————————————————————————————————————————————————
	// MARK: - Private Functions
	// —————————————————————————————————————————————————————————————————————————

	private func configureBackGroundView() {
		self.view.layer.cornerRadius = 10
		self.view.backgroundColor = .secondarySystemBackground
	}

	private func layOutUI() {
		self.view.addSubview(self.stackView)
		self.view.addSubview(self.actionButton)

		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		let padding: CGFloat = 20

		NSLayoutConstraint.activate([
			self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: padding),
			self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
			self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
			self.stackView.heightAnchor.constraint(equalToConstant: 50),

			self.actionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -padding),
			self.actionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
			self.actionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
			self.actionButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}

	private func configureActionButton() {
		self.actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
	}

	@objc
	func actionButtonTapped() {}

	private func configureStackView() {
		self.stackView.axis = .horizontal
		self.stackView.distribution = .equalSpacing

		self.stackView.addArrangedSubview(self.itemInfoViewOne)
		self.stackView.addArrangedSubview(self.itemInfoViewTwo)
	}
}
