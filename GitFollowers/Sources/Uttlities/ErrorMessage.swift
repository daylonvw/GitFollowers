//
//  ErrorMessage.swift
//  GitFollowers
//
//  Created by Daylon van wel on 09/06/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import Foundation

enum ErrorMessage: String {
	case invalidUserName = "This username created an invalid request. Please tty again"
	case unableToComplete = "Unable to complete your request, Please check your internet connection"
	case invalidResponse = "Invalid response from the server. Please try again"
	case invalidData = "The data received from the server was invalid, Please try again"
}
