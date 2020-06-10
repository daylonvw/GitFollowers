//
//  NetworkManager.swift
//  GitFollowers
//
//  Created by Daylon van wel on 09/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import UIKit

class NetworkManager {
	static let shared = NetworkManager()
	private let baseURL = "https://api.github.com/users/"
	let cache = NSCache<NSString, UIImage>()

	private init() {}

	func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
		let endpoint = self.baseURL + "\(username)/followers?per_page=100&page=\(page)"

		guard let url = URL(string: endpoint) else {
			return completed(.failure(.invalidUserName))
		}

		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let _ = error {
				completed(.failure(.unableToComplete))
			}

			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				return completed(.failure(.invalidResponse))
			}

			guard let data = data else {
				return completed(.failure(.invalidData))
			}

			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let followers = try decoder.decode([Follower].self, from: data)
				completed(.success(followers))
			} catch {
				completed(.failure(.invalidData))
			}

		}

		task.resume()
	}

}
