//
//  PersitenceManager.swift
//  GitFollowers
//
//  Created by Daylon van wel on 10/08/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import Foundation

enum PersitenceActionType {
	case add, remove
}

enum PersitenceManager {

	enum keys {
		static let favorites = "favorites"
	}

	static private let defaults = UserDefaults.standard

	static func updateWith(favorite: Follower, actionType: PersitenceActionType, completed: @escaping  (GFError?) -> Void) {
		self.retreiveFavorites { (result) in
			switch result {
				case .success(let favorites):
					var retreivedFavorites = favorites

					switch actionType {

						case .add:
							guard !retreivedFavorites.contains(favorite) else {
								completed(.alreadyInFavorites)
								return
							}

							retreivedFavorites.append(favorite)
						case .remove:
							retreivedFavorites.removeAll { $0.login == favorite.login}
					}

					completed(save(favorites: favorites))

				case .failure(let error):
					completed(error)
			}
		}
	}

	static func retreiveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
		guard let favoritesData = self.defaults.object(forKey: keys.favorites) as? Data else {
			completed(.success([]))
			return
		}

		do {
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			let favorites = try decoder.decode([Follower].self, from: favoritesData)
			completed(.success(favorites))
		} catch {
			completed(.failure(.unableToFavorite))
		}
	}

	static func save(favorites: [Follower]) -> GFError? {
		do {
			let encoder = JSONEncoder()
			let encodedFavorites = try encoder.encode(favorites)
			self.defaults.set(encodedFavorites, forKey: keys.favorites)

			return nil
		} catch {
			return .unableToFavorite
		}
	}
}
