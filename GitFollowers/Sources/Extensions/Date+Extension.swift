//
//  Date+Extension.swift
//  GitFollowers
//
//  Created by Daylon van wel on 24/07/2020.
//  Copyright © 2020 Daylon van Wel. All rights reserved.
//

import Foundation

extension Date {

	func convertToMonthYearFormat() -> String {
		let dateformatter = DateFormatter()
		dateformatter.dateFormat = "MMM yyyy"

		return dateformatter.string(from: self)
	}
}
