//
//  UIViewController+Extension.swift
//  GitFollowers
//
//  Created by Daylon van wel on 06/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

extension UIViewController {

	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			self.present(alertVC, animated: true)
		}
	}
}
