//
//  UIViewController+Extension.swift
//  GitFollowers
//
//  Created by Daylon van wel on 06/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit
import SafariServices


fileprivate var containerView: UIView!

extension UIViewController {

	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			self.present(alertVC, animated: true)
		}
	}

	func showLoadingView() {
		containerView = UIView(frame: self.view.bounds)
		self.view.addSubview(containerView)
		containerView.backgroundColor = .systemBackground
		containerView.alpha = 0

		UIView.animate(withDuration: 1/3) {
			containerView.alpha = 0.8
		}

		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)

		activityIndicator.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
		])

		activityIndicator.startAnimating()
	}

	func dismissLoadingView() {
		DispatchQueue.main.async {
			containerView.removeFromSuperview()
			containerView = nil
		}
	}

	func showEmptyStateView(with message: String, in view: UIView) {
		let emptyStateView = GFEmpyStateView(message: message)
		emptyStateView.frame = view.bounds
		view.addSubview(emptyStateView)
	}

	func presentSafariController(with url: URL)  {
		let safariController = SFSafariViewController(url: url)
		self.present(safariController, animated: true)
	}
}
