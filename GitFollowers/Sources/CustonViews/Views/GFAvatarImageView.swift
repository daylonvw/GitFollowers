//
//  GFAvatarImageView.swift
//  GitFollowers
//
//  Created by Daylon van wel on 10/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

	let cache = NetworkManager.shared.cache
	let placeHolderImage = UIImage(named: "avatar-placeholder")

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.configure()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configure() {
		self.layer.cornerRadius = 10
		self.clipsToBounds = true
		self.image = placeHolderImage
		self.translatesAutoresizingMaskIntoConstraints = false
	}

	func downloadImage(from urlString: String) {

		let cacheKey = NSString(string: urlString)
		if let image = self.cache.object(forKey: cacheKey) {
			self.image = image
			return
		}

		guard let url = URL(string: urlString) else { return }

		let task = URLSession.shared.dataTask(with: url) { [weak self] (data, responce, error) in
			guard let self = self else { return }

			if error != nil { return }
			guard let response = responce as? HTTPURLResponse, response.statusCode == 200 else { return }
			guard let data = data else { return }
			guard let image = UIImage(data: data) else { return }

			self.cache.setObject(image, forKey: cacheKey)
			
			DispatchQueue.main.async {
				self.image = image

			}
		}

		task.resume()
	}
}
