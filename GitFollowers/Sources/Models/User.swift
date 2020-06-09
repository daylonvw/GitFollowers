//
//  User.swift
//  GitFollowers
//
//  Created by Daylon van wel on 09/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import Foundation

struct User: Codable {
	var login: String
	var avatarUrl: String
	var name: String?
	var location: String?
	var bio: String?
	var publicRepos: Int
	var publicGists: Int
	var htmlUrl: String
	var following: Int
	var followers: Int
	var createdAt: String?
}
