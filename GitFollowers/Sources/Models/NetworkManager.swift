//
//  NetworkManager.swift
//  GitFollowers
//
//  Created by Daylon van wel on 09/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import Foundation

class NetworkManager {
	static let shared = NetworkManager()
	let baseURL = "https://api.github.com/users/"

	private init() {}

	func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, ErrorMessage?) -> Void) {
		let endpoint = self.baseURL + "\(username)/followers?per_page=100&page\(page)"

		guard let url = URL(string: endpoint) else {
			return completed(nil, .invalidUserName)
		}

		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let _ = error {
				completed(nil, .unableToComplete)
			}

			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				return completed(nil, .invalidResponse)
			}

			guard let data = data else {
				return completed(nil, .invalidData)
			}

			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let followers = try decoder.decode([Follower].self, from: data)
				completed(followers, nil)
			} catch {
				completed(nil, .invalidData)
			}

		}

		task.resume()
	}


}
